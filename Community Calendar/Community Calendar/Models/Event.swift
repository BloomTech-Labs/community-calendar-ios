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
        self.ticketPrice = event.ticketPrice
    }
    
    let title: String
    let description: String
    let images: [String]
    let startDate: Date?
    let endDate: Date?
    let creator: String
    let rsvps: [String]
    let urls: [String]
    let locations: [Location]
    let tags: [Tag]
    let ticketPrice: Double
}
