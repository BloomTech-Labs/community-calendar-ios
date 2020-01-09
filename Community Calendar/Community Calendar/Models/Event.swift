//
//  Event.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 12/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

import Foundation

struct Event: Codable {
    init(event: GetEventsQuery.Data.Event) {
        self.title = event.title
        self.description = event.description
        self.startDate = dateFormatter.date(from: event.start)
        self.endDate = dateFormatter.date(from: event.end)
        self.creator = "\(event.creator?.firstName ?? "") \(event.creator?.lastName ?? "")"
        self.urls = [String]()
        self.images = [String]()
        self.rsvps = [String]()
        self.locations = [Location]()
        self.tags = [Tag]()
        
        for url in event.urls ?? [] {
            self.urls.append(url.url)
        }
        for rsvp in event.rsvps ?? [] {
            self.rsvps.append("\(rsvp.firstName ?? "") \(rsvp.lastName ?? "")")
        }
        for image in event.eventImages ?? [] {
            self.images.append(image.url)
        }
        for location in event.locations ?? [] {
            self.locations.append(Location(location: location))
        }
        for tag in event.tags ?? [] {
            self.tags.append(Tag(tag: tag))
        }
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

struct Location: Codable {
    init(location: GetEventsQuery.Data.Event.Location) {
        self.latitude = nil
        self.longitude = nil
        if let longString = location.longitude { self.longitude = Double(longString) }
        if let latString = location.latitude { self.latitude = Double(latString) }
        self.name = location.name
        self.state = location.state
        self.city = location.city
        self.streetAddress = location.streetAddress
        self.streetAddress2 = location.streetAddress_2
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

struct Tag: Codable {
    init(tag: GetEventsQuery.Data.Event.Tag) {
        self.title = tag.title
//        self.id = tag.id // Custom type, will implement later
        self.id = nil
    }
    
    let title: String
    let id: Int?
}
