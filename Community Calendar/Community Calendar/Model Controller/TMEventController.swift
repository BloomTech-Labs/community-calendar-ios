//
//  TMEventController.swift
//  Community Calendar
//
//  Created by Michael on 4/20/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import Foundation

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

let baseURL = URL(string: "https://app.ticketmaster.com/discovery/v2/events")!
let apiKey = "n4XTh9yhi2qsN8hRhefbyzMyDPjjeBk7"

class TMEventController {
    
    var events: [EasyEvent] = []
    
    func getEvents(completion: @escaping (Error?, [EasyEvent]?) -> Void) {
        let eventURL = baseURL.appendingPathExtension("json")
        
        var urlComponents = URLComponents(url: eventURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [URLQueryItem(name: "apikey", value: apiKey),
                                     URLQueryItem(name: "marketId", value: "41"),
                                     URLQueryItem(name: "size", value: "100")]
        guard let requestURL = urlComponents?.url else { return }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        print(request)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                print("Bad HTTP URL Response: \(response)")
                DispatchQueue.main.async {
                    completion(error, nil)
                }
                return
            }
            if let error = error {
                print("Error fetching events: \(error)")
                DispatchQueue.main.async {
                    completion(error, nil)
                }
                return
            }
            guard let data = data else {
                print("No data returned from data task.")
                DispatchQueue.main.async {
                    completion(error, nil)
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                //                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0))
                //                print(json)
                let fetchedEvents = try decoder.decode(Events.self, from: data).embedded
                for event in fetchedEvents.events {
                    if let easyEvent = EasyEvent(ticketMasterEvent: event) {
                        self.events.append(easyEvent)
                        let newEvent = EasyEvent(ticketMasterEvent: event)
                    }
                }
                let formatter = DateFormatter()
                formatter.timeZone = .current
                formatter.dateStyle = .medium
                formatter.timeStyle = .medium
                print(self.events)
                print(self.events.count)
                DispatchQueue.main.async {
                    completion(nil, self.events)
                }
                return 
            } catch {
                print("Error decoding event objects: \(error)")
                DispatchQueue.main.async {
                    completion(error, nil)
                }
                return
            }
        }.resume()
    }
}
