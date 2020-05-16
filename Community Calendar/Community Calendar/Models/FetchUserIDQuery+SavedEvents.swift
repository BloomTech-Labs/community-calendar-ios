//
//  FetchUserIDQuery+SavedEvents.swift
//  Community Calendar
//
//  Created by Michael on 5/13/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import Foundation

extension FetchUserIdQuery.Data.User.Saved {
    public var startDate: Date {
        backendDateFormatter.date(from: start) ?? Date()
    }
    
    public var endDate: Date {
        backendDateFormatter.date(from: end) ?? Date()
    }
}
