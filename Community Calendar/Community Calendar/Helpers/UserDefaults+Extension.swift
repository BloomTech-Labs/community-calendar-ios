//
//  UserDefaults+Extension.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 2/6/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import Foundation

extension UserDefaults {
    static var searchPersistanceKey = "SearchController.filter"
    
    enum Keys: String, CaseIterable {
        case oktaID
        case graphQLID
        case oktaEmail
    }
    
    func reset() {
        Keys.allCases.forEach { removeObject(forKey: $0.rawValue) }
    }
}
