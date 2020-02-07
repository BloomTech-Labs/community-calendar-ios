//
//  SearchController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/30/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import Foundation

class SearchController {
    private let userDefaults = UserDefaults.standard // Use userdefaults to store user's searches
    // Note: This is stored locally. Search results will remain the same regardless of account signed in
    // You could append the user's Id or something unique to the key to get user specific results
    
    func save(filteredSearch: [Filter]) {
        let arr = filteredSearch + loadFromPersistantStore()
        userDefaults.setValue(try? PropertyListEncoder().encode(arr), forKey: UserDefaults.searchPersistanceKey)
    }
    
    func loadFromPersistantStore() -> [Filter] {
        guard let data = userDefaults.object(forKey: UserDefaults.searchPersistanceKey) as? Data, let decodedArray = try? PropertyListDecoder().decode([Filter].self, from: data) else { return [] }
        return decodedArray
    }
    
    func clearSearches() {
        userDefaults.setValue(nil, forKey: UserDefaults.searchPersistanceKey)
    }
}
