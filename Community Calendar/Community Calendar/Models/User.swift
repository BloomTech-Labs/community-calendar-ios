//
//  User.swift
//  Community Calendar
//
//  Created by Michael on 5/13/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import Foundation

struct User {
    let id: String
    let firstName: String
    let lastName: String
    let profileImage: String
    let attendingEvents: [Event]?
    let savedEvents: [Event]?
    let createdEvents: [Event]?
    
    init(id: String, firstName: String, lastName: String, profileImage: String, attendingEvents: [Event]?, savedEvents: [Event]?, createdEvents: [Event]?) {
        
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.profileImage = profileImage
        self.attendingEvents = attendingEvents
        self.savedEvents = savedEvents
        self.createdEvents = createdEvents
    }
    
    init?(user: FetchUserIdQuery.Data.User) {
    
        guard
            let firstName = user.firstName,
            let lastName = user.lastName,
            let profileImage = user.profileImage
            else { return nil }
        
        
        self.id = user.id
        self.firstName = firstName
        self.lastName = lastName
        self.profileImage = profileImage
        var attendingEventsArray: [Event] = []
        if let attendingEvents = user.rsvps {
            for event in attendingEvents {
                let rsvpEvent = Event(attending: event)
                attendingEventsArray.append(rsvpEvent)
            }
        }
        self.attendingEvents = attendingEventsArray
        
        var savedEventsArray: [Event] = []
        if let savedEvents = user.saved {
            for event in savedEvents {
                let eventSaved = Event(saved: event)
                savedEventsArray.append(eventSaved)
            }
        }
        self.savedEvents = savedEventsArray
        
        var createdEventsArray: [Event] = []
        if let createdEvents = user.createdEvents {
            for event in createdEvents {
                let eventCreated = Event(created: event)
                createdEventsArray.append(eventCreated)
            }
        }
        self.createdEvents = createdEventsArray
    }
}
