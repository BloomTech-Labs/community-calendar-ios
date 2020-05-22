//
//  Location.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/28/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import Foundation
import CoreLocation

struct Location: Codable, Equatable, Hashable {
    
    let id: String
    let name: String?
    let streetAddress: String
    let streetAddress2: String?
    let city: String
    let state: String
    let zipcode: Int
    let longitude: Double?
    let latitude: Double?
    
    init(id: String, name: String?, streetAddress: String, streetAddress2: String?, city: String, state: String, zipcode: Int, longitude: Double?, latitude: Double?) {
        
        self.id = id
        self.name = name
        self.streetAddress = streetAddress
        self.streetAddress2 = streetAddress2
        self.city = city
        self.state = state
        self.zipcode = zipcode
        self.longitude = longitude
        self.latitude = latitude
    }
    
    init(attending: FetchUserIdQuery.Data.User.Rsvp.Location) {
        self.id = attending.id
        self.name = attending.name
        self.streetAddress = attending.streetAddress
        self.streetAddress2 = attending.streetAddress2
        self.city = attending.city
        self.state = attending.state
        self.zipcode = attending.zipcode
        self.longitude = attending.longitude
        self.latitude = attending.latitude
    }
    
    init(saved: FetchUserIdQuery.Data.User.Saved.Location) {
        self.id = saved.id
        self.name = saved.name
        self.streetAddress = saved.streetAddress
        self.streetAddress2 = saved.streetAddress2
        self.city = saved.city
        self.state = saved.state
        self.zipcode = saved.zipcode
        self.longitude = saved.longitude
        self.latitude = saved.latitude
    }
    
    init(created: FetchUserIdQuery.Data.User.CreatedEvent.Location) {
        self.id = created.id
        self.name = created.name
        self.streetAddress = created.streetAddress
        self.streetAddress2 = created.streetAddress2
        self.city = created.city
        self.state = created.state
        self.zipcode = created.zipcode
        self.longitude = created.longitude
        self.latitude = created.latitude
    }
    
    
//    init(location: GetEventsQuery.Data.Event.Location) {
//        if let longString = location.longitude { self.longitude = Double(longString) }
//        else { self.longitude = nil }
//        if let latString = location.latitude { self.latitude = Double(latString) }
//        else { self.latitude = nil }
//        self.name = location.name
//        self.state = location.state
//        self.city = location.city
//        self.streetAddress = location.streetAddress
//        self.streetAddress2 = location.streetAddress2
//        self.zipcode = location.zipcode
//    }
    
//    init(location: GetEventsByFilterQuery.Data.Event.Location) {
//        if let longString = location.longitude { self.longitude = Double(longString) }
//        else { self.longitude = nil }
//        if let latString = location.latitude { self.latitude = Double(latString) }
//        else { self.latitude = nil }
//        self.name = location.name
//        self.state = location.state
//        self.city = location.city
//        self.streetAddress = location.streetAddress
//        self.streetAddress2 = location.streetAddress2
//        self.zipcode = location.zipcode
//    }
    
    
}

struct LocationFilter: Codable, Equatable {
    let longitude: Double
    let latitude: Double
    let radius: Int
    let name: String
    let row: Int?
}
