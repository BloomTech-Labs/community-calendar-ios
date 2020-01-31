//
//  SearchController.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/30/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import Foundation

class SearchController {
    private let userDefaults = UserDefaults.standard // Use userdefaults to store user's searches
    // Note: This is stored locally. Search results will remain the same regardless of account signed in.
    
    func save(filteredSearch: Filter) {
        var tempArr = loadFromPersistantStore()
        userDefaults.setValue(tempArr.append(filteredSearch), forKey: searchPersistanceKey)
    }
    
    func loadFromPersistantStore() -> [Filter] {
        let storedFilters = userDefaults.object(forKey: searchPersistanceKey)
        guard let data = storedFilters as? Data, let decodedArray = try? JSONDecoder().decode([Filter].self, from: data) else { return [] }
        return decodedArray
    }
    
    func clearSearches() {
        userDefaults.setValue(nil, forKey: searchPersistanceKey)
    }
}
