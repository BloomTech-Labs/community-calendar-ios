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
    private let graphQLClient = ApolloClient(url: URL(string: "https://ccstaging.herokuapp.com/graphql")!)
    private let cache = Cache<String, UIImage>()
    
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
    
    func loadImage(for key: String, cache: Cache<String, UIImage>?, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let cache = cache, let image = cache.fetch(key: key) {
            completion(.success(image))
            return
        }
        
        let imageURL = URL(string: key)!
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            if let error = error {
                NSLog("\(#file):L\(#line): Unable to fetch image data inside \(#function) with error: \(error)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                NSLog("\(#file):L\(#line): No data returned while trying to fetch image data inside \(#function)")
                completion(.failure(NSError()))
                return
            }
            
            if let image = UIImage(data: data) {
                if let cache = cache {
                    cache.imageDict[key] = image
                    completion(.success(image))
                } else {
                    self.cache.imageDict[key] = image
                    completion(.success(image))
                }
            }
        }.resume()
    }
}
