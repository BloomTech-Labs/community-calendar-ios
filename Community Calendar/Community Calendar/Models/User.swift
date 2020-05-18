//
//  User.swift
//  Community Calendar
//
//  Created by Michael on 5/13/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import Foundation

struct User {
    var id: String
    var firstName: String
    var lastName: String
    var profileImage: String
    var userEvents: [UserEvent]?
    
    
    init(id: String, firstName: String, lastName: String, profileImage: String, userEvent: [UserEvent]?) {
        
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.profileImage = profileImage
        self.userEvents = userEvent
    }
    
//    init?(user: FetchUserIdQuery.Data.User) {
//    
//        guard
//            let firstName = user.firstName,
//            let lastName = user.lastName,
//            let profileImage = user.profileImage
//            else { return nil }
//        
//        
//        self.id = user.id
//        self.firstName = firstName
//        self.lastName = lastName
//        self.profileImage = profileImage
//        var attendingEventsArray: [Event] = []
//        if let attendingEvents = user.rsvps {
//            for event in attendingEvents {
//                let rsvpEvent = Event(attending: event)
//                attendingEventsArray.append(rsvpEvent)
//            }
//        }
//        self.attendingEvents = attendingEventsArray
//        
//        var savedEventsArray: [Event] = []
//        if let savedEvents = user.saved {
//            for event in savedEvents {
//                let eventSaved = Event(saved: event)
//                savedEventsArray.append(eventSaved)
//            }
//        }
//        self.savedEvents = savedEventsArray
//        
//        var createdEventsArray: [Event] = []
//        if let createdEvents = user.createdEvents {
//            for event in createdEvents {
//                let eventCreated = Event(created: event)
//                createdEventsArray.append(eventCreated)
//            }
//        }
//        self.createdEvents = createdEventsArray
//    }
}
