//
//  Event.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 12/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

import Foundation

struct Event: Codable {
    let title: String
    let description: String
    let images: [String]
    let startDate: Date
    let endDate: Date
    let creator: String
    let rsvps: [String]
    let urls: [String]
    let locations: [Location]
    let tags: [Tag]
}

struct Location: Codable {
    let longitude: Double
    let latitude: Double
    let name: String
    let state: String
    let city: String
    let streetAddress: String
    let streetAddress2: String
    let zipcode: Int
    let tags: [String]
}

struct Tag: Codable {
    let name: String
    let id: Int
}
