//
//  Notification.Name+Extension.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/16/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import Foundation

extension Notification.Name {
    // Use varible instead of string for notification pattern to take advantage of autocomplete
    static var imageWasLoaded: Notification.Name {
        .init(rawValue: "EventController.imageWasLoaded")
    }
}
