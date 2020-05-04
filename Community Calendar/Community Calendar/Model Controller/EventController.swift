//
//  EventController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/9/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import Foundation
import Apollo
import OktaOidc

enum qlError {
    case ql([GraphQLError])
    case rr(Error)
}

// Run this command in terminal to generate an updated schema.json:
// (You must have apollo installed)
// apollo schema:download --endpoint=https://ccstaging.herokuapp.com/schema.graphql schema.json
// or
// apollo schema:download --endpoint=https://ccapollo-production.herokuapp.com/schema.graphql schema.json

class EventController: HTTPNetworkTransportDelegate {
    
    //  Use staging (https://ccstaging.herokuapp.com/schema.graphql) when developing, use production (https://ccapollo-production.herokuapp.com/graphql) when releasing
//    private static let url = URL(string: "https://ccapollo-production.herokuapp.com/graphql")!
    private static let url = URL(string: "https://apollo.ourcommunitycal.com/")!
    private var graphQLClient: ApolloClient = ApolloClient(url: EventController.url)
    var stateManager: OktaOidcStateManager?
    var oktaOidc: OktaOidc?
    var parent: Controller!
    
    func getEvents(completion: @escaping (Swift.Result<[Event], Error>) -> Void) {
        graphQLClient.fetch(query: GetEventsQuery()) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let graphQLResult):
                guard let data = graphQLResult.data?.events else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                
                var events = [Event]()
                for event in data {
                    events.append(Event(event: event))
                }
                let sortedEvents = events.sorted { a, b -> Bool in
                    if let aStartDate = a.startDate, let bStartDate = b.startDate {
                        return aStartDate < bStartDate
                    } else {
                        return a.title.lowercased() < b.title.lowercased()
                    }
                }
                completion(.success(sortedEvents))
            }
        }
    }
    
    func getEvents(by filters: Filter, completion: @escaping (Swift.Result<[Event], Error>) -> Void) {
        graphQLClient.fetch(query: GetEventsByFilterQuery(filters: filters.searchFilter)) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let graphQLResult):
                guard let data = graphQLResult.data?.events else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                
                var events = [Event]()
                for event in data {
                    events.append(Event(event: event))
                }
                let sortedEvents = events.sorted { a, b -> Bool in
                    if let aStartDate = a.startDate, let bStartDate = b.startDate {
                        return aStartDate < bStartDate
                    } else {
                        return a.title.lowercased() < b.title.lowercased()
                    }
                }
                completion(.success(sortedEvents))
            }
        }
    }
    
    func fetchTags(completion: @escaping (Swift.Result<[Tag], Error>) -> Void) {
        graphQLClient.fetch(query: GetTagsQuery()) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let tagData):
                guard let tagList = tagData.data?.tags else { return }
                var tags = [Tag]()
                for tag in tagList {
                    tags.append(Tag(tag: tag))
                }
                completion(.success(tags))
            }
        }
    }
    
    func rsvpToEvent(with id: String, completion: @escaping (Bool?, qlError?) -> Void) {
        do {
            self.oktaOidc =  try OktaOidc()
        } catch {
            print("Error creating oktaOidc object.")
        }
        
        self.stateManager = OktaOidcStateManager.readFromSecureStorage(for: oktaOidc!.configuration)
        graphQLClient = configureApolloClient(stateManager: self.stateManager!)
        graphQLClient.perform(mutation: RsvpToEventMutation(id: EventIdInput(id: id))) { result in
            switch result {
            case .failure(let error):
                completion(nil, .rr(error))
            case .success(let data):
                if let errors = data.errors {
                    completion(nil, .ql(errors))
                } else {
                    completion(data.data?.rsvpEvent, nil)
                }
            }
        }
    }
    
    func checkForRsvp(with id: String, completion: @escaping ([String]?, Error?) -> Void) {
        graphQLClient.fetch(query: GetUserRsvPsQuery(id: id)) { result in
            switch result {
            case .failure(let error):
                completion(nil, error)
            case .success(let rsvps):
                if rsvps.data?.users?.isEmpty ?? true {
                    completion([], nil)
                } else {
                    if let userRSVP = rsvps.data?.users?.first {
                        let rsvpIdList = userRSVP.rsvps?.map { $0.id }
                        completion(rsvpIdList, nil)
                    }
                }
            }
        }
    }
    
    func configureApolloClient(stateManager: OktaOidcStateManager) -> ApolloClient {
        guard let accessToken = stateManager.accessToken else { return ApolloClient(url: EventController.url)}
        print("Apollo Client: \(accessToken)")
    
        let token = parent.userToken ?? ""
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(accessToken)"]
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: EventController.url, session: URLSession(configuration: configuration), delegate: self))
    }
}
