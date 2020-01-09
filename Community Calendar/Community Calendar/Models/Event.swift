//
//  Event.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 12/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

import Foundation

struct Event: Codable {
    enum EventKeys: String, CodingKey {
        case title
        case description
        case images = "event_images"
        case startDate = "start"
        case endDate = "end"
        case creator
        case rsvps
        case urls
        case locations
        case tags
    }
    
    let title: String
    let description: String
    let images: [Image]
    let startDate: Date
    let endDate: Date
    let creator: Creator
    let rsvps: [Rsvp]
    let urls: [Url]
    let locations: [Location]
    let tags: [Tag]
}

struct Location: Codable {
    enum LocationKeys: String, CodingKey {
        case longitude
        case latitude
        case name
        case state
        case city
        case streetAddress = "street_address"
        case streetAddress2 = "street_address_2"
        case zipcode
    }
    
    let longitude: Double
    let latitude: Double
    let name: String
    let state: String
    let city: String
    let streetAddress: String
    let streetAddress2: String
    let zipcode: Int
}

struct Creator: Codable {
    enum CreatorKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
    }
    
    let firstName: String
    let lastName: String
}

struct Image: Codable {
    let url: String
}

struct Rsvp: Codable {
    enum RsvpKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
    }
    
    let firstName: String
    let lastName: String
}

struct Url: Codable {
    let url: String
}

struct Tag: Codable {
    let name: String
    let id: Int
}
