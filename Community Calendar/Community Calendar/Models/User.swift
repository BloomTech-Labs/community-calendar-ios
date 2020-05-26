//
//  User.swift
//  Community Calendar
//
//  Created by Michael on 5/13/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

struct User {
    var id: String
    var firstName: String?
    var lastName: String?
    var profileImage: String?
    var userEvents: [Event]?
    var userImage: UIImage?
    var attendingCount: Int?
    var savedCount: Int?
    var createdCount: Int?
    
    
    init(id: String, firstName: String, lastName: String, profileImage: String, userEvent: [Event]? = [], userImage: UIImage?, attendingCount: Int? = 0, savedCount: Int? = 0, createdCount: Int? = 0) {
        
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.profileImage = profileImage
        self.userEvents = userEvent
        self.userImage = userImage
        self.attendingCount = attendingCount
        self.savedCount = savedCount
        self.createdCount = createdCount
    }
    
    init(user: FetchUserIdQuery.Data.User) {
        self.id = user.id
        
        if let firstName = user.firstName, let lastName = user.lastName {
            self.firstName = firstName
            self.lastName = lastName
        } else {
            self.firstName = nil
            self.lastName = nil
        }
        
        if let imageString = user.profileImage {
            self.profileImage = imageString
        }  else {
            self.profileImage = nil
        }
        
        var events: [Event] = []
        if let attendingEvents = user.rsvps {
            for event in attendingEvents {
                let eventRSVP = Event(attending: event)
                events.append(eventRSVP)
            }
        }
        
        if let savedEvents = user.saved {
            for event in savedEvents {
                let eventSaved = Event(saved: event)
                events.append(eventSaved)
            }
        }
        
        if let createdEvents = user.createdEvents {
            for event in createdEvents {
                let eventCreated = Event(created: event)
                events.append(eventCreated)
            }
        }
        self.userEvents = events
        
        if let imageString = user.profileImage, let url = URL(string: imageString), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
            
            self.userImage = image
        }
        
        self.attendingCount = user.rsvps?.count
        self.savedCount = user.saved?.count
        self.createdCount = user.createdEvents?.count
        
    }
}
