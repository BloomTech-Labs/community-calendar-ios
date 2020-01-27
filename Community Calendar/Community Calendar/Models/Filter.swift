//
//  Filter.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/28/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import Foundation

struct Filter {
    init(index: String? = nil, tags: [Tag]? = nil, location: LocationFilter? = nil, ticketRange: (Int, Int)? = nil, dateRange: (Date, Date)? = nil) {
        self.index = index
        self.tags = tags
        self.location = location
        self.dateRange = dateRange
        self.ticketPrice = ticketRange
    }
    
    let index: String?
    let tags: [Tag]?
    let location: LocationFilter?
    let ticketPrice: (Int, Int)?
    let dateRange: (Date, Date)?
    
    var searchFilter: SearchFilters {
        let locationFilter: LocationSearchInput?
        let dateRangeFilter: DateRangeSearchInput?
        var ticketPriceFilter: [TicketPriceSearchInput]?
        
        if let location = location {
            locationFilter = LocationSearchInput(userLongitude: location.longitude, userLatitude: location.latitude, radius: location.radius)
        } else { locationFilter = nil }
        
        if let dateRange = dateRange {
            dateRangeFilter = DateRangeSearchInput(start: backendDateFormatter.string(from: dateRange.0), end: backendDateFormatter.string(from: dateRange.1))
        } else { dateRangeFilter = nil }
        
        if let ticketRange = ticketPrice {
            ticketPriceFilter = [TicketPriceSearchInput(minPrice: ticketRange.0, maxPrice: ticketRange.1)]
        } else { ticketPriceFilter = nil }
        
        return SearchFilters(index: index, location: locationFilter, tags: self.tags?.map({ $0.title }), ticketPrice: ticketPriceFilter, dateRange: dateRangeFilter)
    }
}
