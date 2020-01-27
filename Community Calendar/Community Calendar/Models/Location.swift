//
//  Location.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/28/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import Foundation

struct Location: Codable, Equatable {
    init(location: GetEventsQuery.Data.Event.Location) {
        if let longString = location.longitude { self.longitude = Double(longString) }
        else { self.longitude = nil }
        if let latString = location.latitude { self.latitude = Double(latString) }
        else { self.latitude = nil }
        self.name = location.name
        self.state = location.state
        self.city = location.city
        self.streetAddress = location.streetAddress
        self.streetAddress2 = location.streetAddress2
        self.zipcode = location.zipcode
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
}
