//
//  Tag.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/28/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import Foundation

struct Tag: Codable, Equatable {
    init(tag: FetchUserIdQuery.Data.User.Rsvp.Tag) {
        self.init(title: tag.title, id: tag.id)
    }
    
    init(tag: FetchUserIdQuery.Data.User.Saved.Tag) {
        self.init(title: tag.title, id: tag.id)
    }
    
    init(tag: FetchUserIdQuery.Data.User.CreatedEvent.Tag) {
        self.init(title: tag.title, id: tag.id)
    }
    
    init(title: String, id: String? = nil) {
        self.title = title
        self.id = id
    }
    
    var title: String
    let id: String?
}
