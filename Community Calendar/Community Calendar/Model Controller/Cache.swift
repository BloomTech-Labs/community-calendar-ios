//
//  Cache.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/10/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import Foundation

class Cache<Key, Value> where Key : Hashable {
    private let queue = DispatchQueue(label: "General Cache Queue")
    
    var imageDict: [Key: Value] = [:]
    
    func cache(value: Value, for key: Key) {
        queue.async {
            self.imageDict[key] = value
        }
    }
    
    func fetch(key: Key) -> Value? {
        return queue.sync {
            imageDict[key]
        }
    }
}
