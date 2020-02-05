//
//  EventController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/9/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import Foundation
import Apollo
import JWTDecode
// Run this command in terminal to generate an updated schema.json:
// (You must have apollo installed)
// apollo schema:download --endpoint=https://ccstaging.herokuapp.com/schema.graphql schema.json
// or
// apollo schema:download --endpoint=https://ccapollo-production.herokuapp.com/schema.graphql schema.json

class EventController: HTTPNetworkTransportDelegate {
    //  Use staging (https://ccstaging.herokuapp.com/schema.graphql) when developing, use production (https://ccapollo-production.herokuapp.com/graphql) when releasing
    private static let url = URL(string: "https://ccapollo-production.herokuapp.com/graphql")!
    
    public let cache = Cache<String, UIImage>()
    private var graphQLClient: ApolloClient = ApolloClient(url: EventController.url)
    
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
    
    func fetchImage(for key: String) {
        if let image = cache.fetch(key: key) {
            NotificationCenter.default.post(name: .imageWasLoaded, object: ImageNotification(image: image, url: key))
            return
        }
        
        let imageURL = URL(string: key)!
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            if let error = error {
                NSLog("\(#file):L\(#line): Unable to fetch image data inside \(#function) with error: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("\(#file):L\(#line): No data returned while trying to fetch image data inside \(#function)")
                return
            }
            
            if let image = UIImage(data: data) {
                self.cache.cache(value: image, for: key)
                NotificationCenter.default.post(name: .imageWasLoaded, object: ImageNotification(image: image, url: key))
            }
        }.resume()
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
    
    func rsvpToEvent(with id: String, completion: @escaping (Error?, [GraphQLError]?) -> Void) {
        graphQLClient = updateApollo()
        graphQLClient.perform(mutation: RsvpToEventMutation(id: EventIdInput(id: id))) { result in
            switch result {
            case .failure(let error):
                completion(error, nil)
            case .success(let data):
                completion(nil, (data.errors?.isEmpty ?? true) ? nil : data.errors)
            }
        }
    }
    
    func checkForRSVP(with id: String, completion: @escaping ([String]?, Error?) -> Void) {
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
    
    func updateApollo() -> ApolloClient {
        let token = userToken ?? ""
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(token)"]
        
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: EventController.url, session: URLSession(configuration: configuration), delegate: self))
    }
}
