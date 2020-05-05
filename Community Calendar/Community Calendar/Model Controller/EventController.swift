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

class EventController: NSObject, HTTPNetworkTransportDelegate, URLSessionDelegate {
    
//    private static let url = URL(string: "https://ccapollo-production.herokuapp.com/graphql")!
    private static let url = URL(string: "https://apollo.ourcommunitycal.com/")!
    private var apollo: ApolloClient = ApolloClient(url: EventController.url)
    var stateManager: OktaOidcStateManager?
    var oktaOidc: OktaOidc?
    var parent: Controller!
    
    var events = [FetchEventsQuery.Data.Event]()
    
    private lazy var networkTransport: HTTPNetworkTransport = {
        let transport = HTTPNetworkTransport(url: URL(string: "https://apollo.ourcommunitycal.com/")!)
        transport.delegate = self
        return transport
    }()
    
    func fetchEvents(completion: @escaping (Swift.Result<[FetchEventsQuery.Data.Event], Error>) -> Void) {
        apollo.fetch(query: FetchEventsQuery()) { result in
            guard let data = try? result.get().data else { return }
            print(data)
            switch result {
            case .failure(let error):
                print("Error fetching events: \(error)")
                completion(.failure(error))
            case .success(let graphQLResult):
                print("Success! Result: \(graphQLResult)")
                if let events = graphQLResult.data?.events {
                    self.events.append(contentsOf: events)
                    print(self.events.count)
                    completion(.success(events))
                }
            }
        }
    }
    
    func configureApolloClient(accessToken: String) -> ApolloClient {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(accessToken)"]
        
        let client = URLSessionClient(sessionConfiguration: configuration, callbackQueue: nil)
        let transport = HTTPNetworkTransport(url: EventController.url, client: client)
        print("Apollo Client: \(accessToken)")

        return ApolloClient(networkTransport: transport)
    }
}
