//
//  Controller.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 2/5/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import UIKit
import CoreLocation

class Controller {
//    private var eventController = EventController()
    private var searchController = SearchController()
    public let locationManager = CLLocationManager()
    public let cache = Cache<String, UIImage>()
    
    private var rsvpIds: [String]?
    public var userToken: String?
    
    public var myEvents: [Event] = []
    
    init() {
//        eventController.parent = self
    }
    
//    func getEvents(by filters: Filter? = nil, completion: @escaping (Swift.Result<[Event], Error>) -> Void) {
//        if let filters = filters {
//            eventController.getEvents(by: filters) { result in
//                switch result {
//                case .success(let events):
//                    completion(.success(events))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//        } else {
//            eventController.getEvents { result in
//                switch result {
//                case .success(let events):
//                    completion(.success(events))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//        }
//    }
    
//    func fetchTags(completion: @escaping (Swift.Result<[Tag], Error>) -> Void) {
//        eventController.fetchTags { result in
//            switch result {
//            case .success(let tags):
//                completion(.success(tags))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//
//    func rsvpToEvent(with id: String, completion: @escaping (Bool?, qlError?) -> Void) {
//        eventController.rsvpToEvent(with: id) { bool, errors in
//            if let errors = errors {
//                completion(nil, errors)
//            } else if let bool = bool {
//                completion(bool, nil)
//            }
//        }
//    }
    
    func checkUserRsvps(with id: String?) -> Bool? {
        if let id = id, let rsvpIds = rsvpIds {
            return rsvpIds.contains(id)
        }
        return nil
    }
    
//    func fetchUserRsvps(with id: String, completion: @escaping ([String]?, Error?) -> Void) {
//        eventController.checkForRsvp(with: id) { ids, error in
//            if let error = error {
//                completion(nil, error)
//            } else if let ids = ids {
//                self.rsvpIds = ids
//                completion(ids, nil)
//            }
//        }
//    }
    
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
    
    func save(filteredSearch: Filter) {
        searchController.save(filteredSearch: [filteredSearch])
    }
    
    func loadFromPersistantStore() -> [Filter] {
        return searchController.loadFromPersistantStore()
    }
    
    func clearSearches() {
        searchController.clearSearches()
    }
    
    func remove(filter: Filter) -> Bool {
        var filters = searchController.loadFromPersistantStore()
        if let _ = removeObject(filter, from: &filters) {
            searchController.save(filteredSearch: filters)
            return true
        } else {
            return false
        }
    }
}
