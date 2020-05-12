//
//  Cache.swift
//  Community Calendar
//
//  Created by Michael on 5/12/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import Foundation

class Cache<Key: Hashable, Value> {
    var cache = [Key : Value]()
    let queue = DispatchQueue(label: "Cache Queue")
    
    func cache(value: Value, for key: Key) {
        queue.async {
            self.cache[key] = value
        }
    }
    
    func value(for key: Key) -> Value? {
        return queue.sync { cache[key] }
    }
    
    func clear() {
        queue.async {
            self.cache.removeAll()
        }
    }
}
