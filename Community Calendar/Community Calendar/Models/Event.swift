//
//  Event.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 12/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

import Foundation

struct Event: Codable, Equatable {
    init(event: GetEventsQuery.Data.Event) {
        self.title = event.title
        self.description = event.description
        self.startDate = backendDateFormatter.date(from: event.start)
        self.endDate = backendDateFormatter.date(from: event.end)
        self.creator = "\(event.creator?.firstName ?? "") \(event.creator?.lastName ?? "")"
        self.urls = event.urls?.map( { ($0.url) } ) ?? []
        self.images = event.eventImages?.map( { ($0.url) } ) ?? []
        self.rsvps = event.rsvps?.map( { ("\($0.firstName ?? "") \($0.lastName ?? "")") } ) ?? []
        self.locations = event.locations?.map( { (Location(location: $0)) } ) ?? []
        self.tags = event.tags?.map( { (Tag(tag: $0)) } ) ?? []
    }
    
    let title: String
    let description: String
    var images: [String]
    let startDate: Date?
    let endDate: Date?
    let creator: String
    var rsvps: [String]
    var urls: [String]
    var locations: [Location]
    var tags: [Tag]
}

struct Location: Codable, Equatable {
    init(location: GetEventsQuery.Data.Event.Location) {
        self.latitude = nil
        self.longitude = nil
        if let longString = location.longitude { self.longitude = Double(longString) }
        if let latString = location.latitude { self.latitude = Double(latString) }
        self.name = location.name
        self.state = location.state
        self.city = location.city
        self.streetAddress = location.streetAddress
        self.streetAddress2 = location.streetAddress2
        self.zipcode = location.zipcode
    }
    
    var longitude: Double?
    var latitude: Double?
    let name: String
    let state: String
    let city: String
    let streetAddress: String
    let streetAddress2: String?
    let zipcode: Int
}

struct Tag: Codable, Equatable {
    init(tag: GetEventsQuery.Data.Event.Tag) {
        self.init(title: tag.title, id: tag.id)
    }
    
    init(title: String, id: String? = nil) {
        self.title = title
        self.id = id
    }
    
    let title: String
    let id: String?
}
