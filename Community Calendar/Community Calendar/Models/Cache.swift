//
//  Cache.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/10/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import Foundation

class Cache<Key, Value> where Key : Hashable {
    private let queue = DispatchQueue(label: "com.lambdaschool.Community-Calendar.cache")
    private var cache = [Key : Value]()
    
    func cache(value: Value, for key: Key) {
        queue.async {
            self.cache[key] = value
        }
    }
    
    func fetch(key: Key) -> Value? {
        return queue.sync {
            cache[key]
        }
    }
    
    func clear() {
        queue.async {
            self.cache.removeAll()
        }
    }
}
