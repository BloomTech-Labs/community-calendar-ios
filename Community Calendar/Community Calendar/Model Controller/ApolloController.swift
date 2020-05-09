//
//  ApolloClient.swift
//  Community Calendar
//
//  Created by Michael on 5/5/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import Foundation
import Apollo
import OktaOidc

class ApolloController: NSObject, HTTPNetworkTransportDelegate, URLSessionDelegate {

    private static let url = URL(string: "https://apollo.ourcommunitycal.com/")!
    var apollo: ApolloClient = ApolloClient(url: ApolloController.url)
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
        let transport = HTTPNetworkTransport(url: ApolloController.url, client: client)
        
        transport.delegate = self
        print("Apollo Client: \(accessToken)")
        
        return ApolloClient(networkTransport: transport)
    }
}
