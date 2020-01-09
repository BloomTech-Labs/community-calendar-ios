//
//  EventController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/9/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import Foundation
import Apollo
// Run this command in terminal to generate an updated schema.json:
// apollo schema:download --endpoint=https://ccstaging.herokuapp.com/schema.graphql schema.json
class EventController {
    let graphQLClient = ApolloClient(url: URL(string: "https://ccstaging.herokuapp.com/graphql")!)
    
    func getEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
        graphQLClient.fetch(query: GetEventsQuery()) { result in
            switch result {
            case .failure(let error):
                NSLog("\(#file):L\(#line): Error fetching events inside \(#function) with error: \(error)")
                completion(.failure(error))
            case .success(let graphQLResult):
                guard let data = graphQLResult.data?.events else { return }
                
                var events = [Event]()
                for event in data {
                    events.append(Event(event: event))
                }
                completion(.success(events))
            }
        }
    }
}
