//
//  TicketMasterEvent.swift
//  Community Calendar
//
//  Created by Michael on 4/20/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import Foundation

struct Events: Codable {
    let embedded: EventsEmbedded
    
    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }
}

struct EventsEmbedded: Codable {
    let events: [TicketMasterEvent]
    
    enum CodingKeys: String, CodingKey {
        case events = "events"
    }
}

struct TicketMasterEvent: Codable {
    let name: String
    let type: String
    let id: String
    let images: [Image]
    let dates: Dates
    let embedded: EventEmbedded
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case type = "type"
        case id = "id"
        case images = "images"
        case dates = "dates"
        case embedded = "_embedded"
    }
}

struct Image: Codable {
    let url: String
    let width: Int
    let height: Int
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case width = "width"
        case height = "height"
    }
}

struct Dates: Codable {
    let start: Start
    let timezone: String
    
    enum CodingKeys: String, CodingKey {
        case start = "start"
        case timezone = "timezone"
    }
}

struct Start: Codable {
    let localDate: String?
    let localTime: String?
    let dateTime: Date?
    
    enum CodingKeys: String, CodingKey {
        case localDate = "localDate"
        case localTime = "localTime"
        case dateTime = "dateTime"
    }
}


struct EventEmbedded: Codable {
    let venues: [Venue]
    
    enum CodingKeys: String, CodingKey {
        case venues = "venues"
    }
}

struct Venue: Codable {
    let name: String
    let location: TMLocation
    let postalCode: String
    let city: City
    let state: State
    let country: Country
    let address: Address
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case location = "location"
        case postalCode = "postalCode"
        case city = "city"
        case state = "state"
        case country = "country"
        case address = "address"
    }
}

struct TMLocation: Codable {
    let longitude: String
    let latitude: String
    
    enum CodingKeys: String, CodingKey {
        case longitude = "longitude"
        case latitude = "latitude"
    }
}

struct Address: Codable {
    let line1: String
    
    enum CodingKeys: String, CodingKey {
        case line1 = "line1"
    }
}

struct City: Codable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
}

struct State: Codable {
    let name: String
    let stateCode: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case stateCode = "stateCode"
    }
}

struct Country: Codable {
    let name: String
    let countryCode: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case countryCode = "countryCode"
    }
}
