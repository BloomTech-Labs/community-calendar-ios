//
//  Event.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 12/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

import Foundation

struct Event: Codable {
    let title: String
    let description: String
    let image: String
    let startDate: Date
    let endDate: Date
}
