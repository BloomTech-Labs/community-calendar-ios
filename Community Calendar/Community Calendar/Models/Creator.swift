//
//  Creator.swift
//  Community Calendar
//
//  Created by Michael on 5/18/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import Foundation

struct Creator: Equatable, Hashable {
    let id: String
    let firstName: String?
    let lastName: String?
    let profileImage: String?
    
    init(id: String, firstName: String?, lastName: String?, profileImage: String?) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.profileImage = profileImage
    }
    
    init?(creator: FetchEventsQuery.Data.Event.Creator) {
        guard
            let firstName = creator.firstName,
            let lastName = creator.lastName,
            let profileImage = creator.profileImage
            else { return nil }
        
        self.id = creator.id
        self.firstName = firstName
        self.lastName = lastName
        self.profileImage = profileImage
    }
    
    init?(creator: FetchUserIdQuery.Data.User.Rsvp.Creator) {
        
        guard
            let firstName = creator.firstName,
            let lastName = creator.lastName,
            let profileImage = creator.profileImage
            else { return nil }
        
        self.id = creator.id
        self.firstName = firstName
        self.lastName = lastName
        self.profileImage = profileImage
    }
    
    init?(creator: FetchUserIdQuery.Data.User.Saved.Creator) {
        
        guard
            let firstName = creator.firstName,
            let lastName = creator.lastName,
            let profileImage = creator.profileImage
            else { return nil }
        
        self.id = creator.id
        self.firstName = firstName
        self.lastName = lastName
        self.profileImage = profileImage
    }
    
    init?(creator: FetchUserIdQuery.Data.User.CreatedEvent.Creator) {
        
        guard
            let firstName = creator.firstName,
            let lastName = creator.lastName,
            let profileImage = creator.profileImage
            else { return nil }
        
        self.id = creator.id
        self.firstName = firstName
        self.lastName = lastName
        self.profileImage = profileImage
    }
}
