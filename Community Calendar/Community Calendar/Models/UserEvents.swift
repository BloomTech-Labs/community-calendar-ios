//
//  UserEvents.swift
//  Community Calendar
//
//  Created by Michael on 5/18/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import Foundation

enum EventType: Equatable, Hashable {
    case attending
    case saved
    case created
}

struct UserEvent: Equatable, Hashable {
    
    static func == (lhs: UserEvent, rhs: UserEvent) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
    }
    
    
    let id: String
    let title: String
    let description: String
    let start: String
    let end: String
    let ticketPrice: Double
    let location: Location?
    let image: String?
    var startDate: Date?
    var endDate: Date?
    let creator: Creator
    let eventType: EventType
    
    init(id: String, title: String, description: String, start: String, end: String, ticketPrice: Double, location: Location?, image: String?, creator: Creator, eventType: EventType) {
        
        self.id = id
        self.title = title
        self.description = description
        self.start = start
        self.end = end
        self.ticketPrice = ticketPrice
        self.location = location
        self.image = image
        self.startDate = backendDateFormatter.date(from: start)
        self.endDate = backendDateFormatter.date(from: end)
        self.creator = creator
        self.eventType = eventType
    }
    
    init(attending: FetchUserIdQuery.Data.User.Rsvp, eventType: EventType = .attending) {
        
        var imageString: String = ""
        if let images = attending.eventImages?.first?.url {
            imageString = images
        }
        
        self.id = attending.id
        self.title = attending.title
        self.description = attending.description
        self.start = attending.start
        self.end = attending.end
        self.ticketPrice = attending.ticketPrice
        self.image = imageString
        self.startDate = backendDateFormatter.date(from: attending.start)
        self.endDate = backendDateFormatter.date(from: attending.end)
        if let location = attending.locations?.first {
            self.location = Location(attending: location)
        } else {
            self.location = Location(id: "N/A", name: "N/A", streetAddress: "N/A", streetAddress2: "N/A", city: "N/A", state: "N/A", zipcode: 00000, longitude: 0.0, latitude: 0.0)
        }
        if let creator = attending.creator, let attendingCreator = Creator(creator: creator) {
            self.creator = attendingCreator
        } else {
            self.creator = Creator(id: "N/A", firstName: "N/A", lastName: "", profileImage: "N/A")
        }
        self.eventType = eventType
    }
    
    init(saved: FetchUserIdQuery.Data.User.Saved, eventType: EventType = .saved) {
        
        var imageString: String = ""
        if let images = saved.eventImages?.first?.url {
            imageString = images
        }
        
        self.id = saved.id
        self.title = saved.title
        self.description = saved.description
        self.start = saved.start
        self.end = saved.end
        self.ticketPrice = saved.ticketPrice
        self.image = imageString
        self.startDate = backendDateFormatter.date(from: saved.start)
        self.endDate = backendDateFormatter.date(from: saved.end)
        if let location = saved.locations?.first {
            self.location = Location(saved: location)
        } else {
            self.location = Location(id: "N/A", name: "N/A", streetAddress: "N/A", streetAddress2: "N/A", city: "N/A", state: "N/A", zipcode: 00000, longitude: 0.0, latitude: 0.0)
        }
        if let creator = saved.creator, let attendingCreator = Creator(creator: creator) {
            self.creator = attendingCreator
        } else {
            self.creator = Creator(id: "N/A", firstName: "N/A", lastName: "", profileImage: "N/A")
        }
        self.eventType = eventType
    }
    
    init(created: FetchUserIdQuery.Data.User.CreatedEvent, eventType: EventType = .created) {
        
        var imageString: String = ""
        if let images = created.eventImages?.first?.url {
            imageString = images
        }
        
        self.id = created.id
        self.title = created.title
        self.description = created.description
        self.start = created.start
        self.end = created.end
        self.ticketPrice = created.ticketPrice
        self.image = imageString
        self.startDate = backendDateFormatter.date(from: created.start)
        self.endDate = backendDateFormatter.date(from: created.end)
        if let location = created.locations?.first {
            self.location = Location(created: location)
        } else {
            self.location = Location(id: "N/A", name: "N/A", streetAddress: "N/A", streetAddress2: "N/A", city: "N/A", state: "N/A", zipcode: 00000, longitude: 0.0, latitude: 0.0)
        }
        if let creator = created.creator, let attendingCreator = Creator(creator: creator) {
            self.creator = attendingCreator
        } else {
            self.creator = Creator(id: "N/A", firstName: "N/A", lastName: "", profileImage: "N/A")
        }
        self.eventType = eventType
    }
}
