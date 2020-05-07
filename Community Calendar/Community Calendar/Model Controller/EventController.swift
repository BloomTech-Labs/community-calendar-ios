//
//  EventController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/9/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import Foundation
import OktaOidc
import Apollo

enum qlError {
    case ql([GraphQLError])
    case rr(Error)
}

// Run this command in terminal to generate an updated schema.json:
// (You must have apollo installed)
// apollo schema:download --endpoint=https://ccstaging.herokuapp.com/schema.graphql schema.json
// or
// apollo schema:download --endpoint=https://ccapollo-production.herokuapp.com/schema.graphql schema.json

class EventController: NSObject, HTTPNetworkTransportDelegate, URLSessionDelegate {
    
    private static let url = URL(string: "https://apollo.ourcommunitycal.com/")!
    var apollo: ApolloClient = ApolloClient(url: EventController.url)
    var stateManager: OktaOidcStateManager?
    var oktaOidc: OktaOidc?
    var parent: Controller!
    
    var events = [FetchEventsQuery.Data.Event]()
    
    
    func fetchEvents(completion: @escaping (Swift.Result<[FetchEventsQuery.Data.Event], Error>) -> Void) {
        apollo.fetch(query: FetchEventsQuery()) { result in
            switch result {
            case .failure(let error):
                print("Error fetching events: \(error)")
                completion(.failure(error))
            case .success(let graphQLResult):
                if let events = graphQLResult.data?.events {
                    self.events.append(contentsOf: events)
                    print(self.events.count)
                    completion(.success(events))
                }
            }
        }
    }
    
    func fetchUserID(oktaID: String, completion: @escaping (Swift.Result<FetchUserIdQuery.Data.User, Error>) -> Void) {
        apollo.fetch(query: FetchUserIdQuery(oktaId: oktaID)) { result in
            switch result {
            case .failure(let error):
                print("Error getting user ID: \(error)")
                completion(.failure(error))
            case .success(let graphQLResult):
                if let userID = graphQLResult.data?.user {
                    print("Current Users backend ID: \(userID)")
                    completion(.success(userID))
                }
            }
        }
    }
    
    func updateProfilePic(image: String, graphQLID: String, completion: @escaping (Swift.Result<AddProfilePicMutation.Data.UpdateUser, Error>) -> Void) {
        apollo.perform(mutation: AddProfilePicMutation(image: image, id: graphQLID)) { result in
            switch result {
            case .failure(let error):
                print("Error updating users profile picture: \(error)")
                completion(.failure(error))
            case .success(let graphQLResult):
                if let userID = graphQLResult.data?.updateUser {
                    print("Updated profile picture successfully for user: \(userID)")
                    completion(.success(userID))
                }
            }
        }
    }
    
    func configureApolloClient(accessToken: String) -> ApolloClient {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(accessToken)"]
        
        let client = URLSessionClient(sessionConfiguration: configuration, callbackQueue: nil)
        let transport = HTTPNetworkTransport(url: EventController.url, client: client)
        
        transport.delegate = self
        print("Apollo Client: \(accessToken)")
        
        return ApolloClient(networkTransport: transport)
    }
    
//    func getEvents(completion: @escaping (Swift.Result<[Event], Error>) -> Void) {
//        graphQLClient.fetch(query: GetEventsQuery()) { result in
//            switch result {
//            case .failure(let error):
//                completion(.failure(error))
//            case .success(let graphQLResult):
//                guard let data = graphQLResult.data?.events else {
//                    completion(.failure(NetworkError.noData))
//                    return
//                }
//
//                var events = [Event]()
//                for event in data {
//                    events.append(Event(event: event))
//                }
//                let sortedEvents = events.sorted { a, b -> Bool in
//                    if let aStartDate = a.startDate, let bStartDate = b.startDate {
//                        return aStartDate < bStartDate
//                    } else {
//                        return a.title.lowercased() < b.title.lowercased()
//                    }
//                }
//                completion(.success(sortedEvents))
//            }
//        }
//    }
    
//    func getEvents(by filters: Filter, completion: @escaping (Swift.Result<[Event], Error>) -> Void) {
//        graphQLClient.fetch(query: GetEventsByFilterQuery(filters: filters.searchFilter)) { result in
//            switch result {
//            case .failure(let error):
//                completion(.failure(error))
//            case .success(let graphQLResult):
//                guard let data = graphQLResult.data?.events else {
//                    completion(.failure(NetworkError.noData))
//                    return
//                }
//
//                var events = [Event]()
//                for event in data {
//                    events.append(Event(event: event))
//                }
//                let sortedEvents = events.sorted { a, b -> Bool in
//                    if let aStartDate = a.startDate, let bStartDate = b.startDate {
//                        return aStartDate < bStartDate
//                    } else {
//                        return a.title.lowercased() < b.title.lowercased()
//                    }
//                }
//                completion(.success(sortedEvents))
//            }
//        }
//    }
    
//    func fetchTags(completion: @escaping (Swift.Result<[Tag], Error>) -> Void) {
//        graphQLClient.fetch(query: GetTagsQuery()) { result in
//            switch result {
//            case .failure(let error):
//                completion(.failure(error))
//            case .success(let tagData):
//                guard let tagList = tagData.data?.tags else { return }
//                var tags = [Tag]()
//                for tag in tagList {
//                    tags.append(Tag(tag: tag))
//                }
//                completion(.success(tags))
//            }
//        }
//    }
    
//    func rsvpToEvent(with id: String, completion: @escaping (Bool?, qlError?) -> Void) {
//        do {
//            self.oktaOidc =  try OktaOidc()
//        } catch {
//            print("Error creating oktaOidc object.")
//        }
//
//        self.stateManager = OktaOidcStateManager.readFromSecureStorage(for: oktaOidc!.configuration)
//        graphQLClient = configureApolloClient(stateManager: self.stateManager!)
//        graphQLClient.perform(mutation: RsvpToEventMutation(id: EventIdInput(id: id))) { result in
//            switch result {
//            case .failure(let error):
//                completion(nil, .rr(error))
//            case .success(let data):
//                if let errors = data.errors {
//                    completion(nil, .ql(errors))
//                } else {
//                    completion(data.data?.rsvpEvent, nil)
//                }
//            }
//        }
//    }
    
//    func checkForRsvp(with id: String, completion: @escaping ([String]?, Error?) -> Void) {
//        graphQLClient.fetch(query: GetUserRsvPsQuery(id: id)) { result in
//            switch result {
//            case .failure(let error):
//                completion(nil, error)
//            case .success(let rsvps):
//                if rsvps.data?.users?.isEmpty ?? true {
//                    completion([], nil)
//                } else {
//                    if let userRSVP = rsvps.data?.users?.first {
//                        let rsvpIdList = userRSVP.rsvps?.map { $0.id }
//                        completion(rsvpIdList, nil)
//                    }
//                }
//            }
//        }
//    }
    
//    func configureApolloClient(accessToken: String) -> ApolloClient {
//        let configuration = URLSessionConfiguration.default
//        configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(accessToken)"]
//
//        let client = URLSessionClient(sessionConfiguration: configuration, callbackQueue: nil)
//        let transport = HTTPNetworkTransport(url: EventController.url, client: client)
//        transport.delegate = self
//        print("Apollo Client: \(accessToken)")
//
//        return ApolloClient(networkTransport: transport)
//    
//    }
}
