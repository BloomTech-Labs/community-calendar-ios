//
//  Tag.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/28/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import Foundation

struct Tag: Codable, Equatable {
    init(tag: GetEventsQuery.Data.Event.Tag) {
        self.init(title: tag.title, id: tag.id)
    }
    
    init(tag: GetEventsByFilterQuery.Data.Event.Tag) {
        self.init(title: tag.title, id: tag.id)
    }
    
    init(title: String, id: String? = nil) {
        self.title = title
        self.id = id
    }
    
    var title: String
    let id: String?
}
