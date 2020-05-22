//
//  Event.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 12/16/19.
//  Copyright © 2019 Lambda School All rights reserved.
//

import Foundation
import CoreLocation

struct Event {
    
    let id: String
    let title: String
    let description: String
    let start: String
    let end: String
    let ticketPrice: Double
    let index: String
    let tags: [Tag]
    let location: Location?
    let image: String?
    var startDate: Date?
    var endDate: Date?
    let creator: Creator
    
    init(id: String, title: String, description: String, start: String, end: String, ticketPrice: Double, index: String, tags: [Tag], location: Location?, image: String?, creator: Creator) {
        
        self.id = id
        self.title = title
        self.description = description
        self.start = start
        self.end = end
        self.ticketPrice = ticketPrice
        self.index = index
        self.tags = tags
        self.location = location
        self.image = image
        self.startDate = backendDateFormatter.date(from: start)
        self.endDate = backendDateFormatter.date(from: end)
        self.creator = creator
    }
    
    init(attending: FetchUserIdQuery.Data.User.Rsvp) {
        
        var tagArray: [Tag] = []
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
        if let tags = attending.tags {
            for tag in tags {
                let newTag = Tag(tag: tag)
                tagArray.append(newTag)
            }
        }
        self.tags = tagArray
        self.index = attending.index
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
            self.creator = Creator(id: "N/A", firstName: "N/A", lastName: "N/A", profileImage: "N/A")
        }
    }
    
    init(saved: FetchUserIdQuery.Data.User.Saved) {
        
        var tagArray: [Tag] = []
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
        if let tags = saved.tags {
            for tag in tags {
                let newTag = Tag(tag: tag)
                tagArray.append(newTag)
            }
        }
        self.tags = tagArray
        self.index = saved.index
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
            self.creator = Creator(id: "N/A", firstName: "N/A", lastName: "N/A", profileImage: "N/A")
        }
    }
    
    init(created: FetchUserIdQuery.Data.User.CreatedEvent) {
        
        var tagArray: [Tag] = []
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
        if let tags = created.tags {
            for tag in tags {
                let newTag = Tag(tag: tag)
                tagArray.append(newTag)
            }
        }
        self.tags = tagArray
        self.index = created.index
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
            self.creator = Creator(id: "N/A", firstName: "N/A", lastName: "N/A", profileImage: "N/A")
        }
    }
}
