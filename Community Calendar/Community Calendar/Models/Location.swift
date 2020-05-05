//
//  Location.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/28/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import Foundation
import CoreLocation

struct Location: Codable, Equatable {
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
    
    init(longitude: Double?, latitude: Double?, name: String, state: String, city: String, streetAddress: String, streetAddress2: String?, zipcode: Int) {
        self.longitude = longitude
        self.latitude = latitude
        self.name = name
        self.state = state
        self.city = city
        self.streetAddress = streetAddress
        self.streetAddress2 = streetAddress2
        self.zipcode = zipcode
    }
    
    let longitude: Double?
    let latitude: Double?
    let name: String
    let state: String
    let city: String
    let streetAddress: String
    let streetAddress2: String?
    let zipcode: Int
}

struct LocationFilter: Codable, Equatable {
    let longitude: Double
    let latitude: Double
    let radius: Int
    let name: String
    let row: Int?
}
