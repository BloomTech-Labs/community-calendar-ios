//
//  Event.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 12/16/19.
//  Copyright © 2019 Lambda School All rights reserved.
//

import Foundation
import CoreLocation

//struct Event {
//    
//    let id: String
//    let title: String
//    let description: String
//    let start: String
//    let end: String
//    let ticketPrice: Double
//    let location: Location?
//    let image: String?
//    var startDate: Date?
//    var endDate: Date?
//    let creator: Creator?
//    
//    init(id: String, title: String, description: String, start: String, end: String, ticketPrice: Double, location: Location?, image: String?, creator: Creator) {
//        
//        self.id = id
//        self.title = title
//        self.description = description
//        self.start = start
//        self.end = end
//        self.ticketPrice = ticketPrice
//        self.location = location
//        self.image = image
//        self.startDate = backendDateFormatter.date(from: start)
//        self.endDate = backendDateFormatter.date(from: end)
//        self.creator = creator
//    }
//    
//    init(event: FetchEventsQuery.Data.Event) {
//
//        var imageString: String = ""
//        if let images = event.eventImages?.first?.url {
//            imageString = images
//        }
//
//        self.id = event.id
//        self.title = event.title
//        self.description = event.description
//        self.start = event.start
//        self.end = event.end
//        self.ticketPrice = event.ticketPrice
//        self.image = imageString
//        self.startDate = backendDateFormatter.date(from: event.start)
//        self.endDate = backendDateFormatter.date(from: event.end)
//        if let location = event.locations?.first {
//            self.location = Location(event: location)
//        } else {
//            self.location = Location(id: "N/A", name: "N/A", streetAddress: "N/A", streetAddress2: "N/A", city: "N/A", state: "N/A", zipcode: 00000, longitude: 0.0, latitude: 0.0)
//        }
//        if let creator = event.creator, let attendingCreator = Creator(creator: creator) {
//            self.creator = attendingCreator
//        } else {
//            self.creator = Creator(id: "N/A", firstName: nil, lastName: nil, profileImage: nil)
//        }
//    } 
//}
