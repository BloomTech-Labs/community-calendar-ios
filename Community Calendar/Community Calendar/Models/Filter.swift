//
//  Filter.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/28/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import Foundation

struct Filter: Codable {
    init(index: String? = nil, tags: [Tag]? = nil, location: LocationFilter? = nil, ticketPrice: (Int, Int)? = nil, dateRange: (Date, Date)? = nil) {
        self.index = index
        self.tags = tags
        self.location = location
        if let dateRange = dateRange {
            self.dateRange = DateRangeFilter(dateRange: dateRange)
        }
        if let ticketPrice = ticketPrice {
            self.ticketPrice = TicketPriceFilter(ticketFilter: ticketPrice)
        }
    }
    
    var index: String?
    var tags: [Tag]?
    var location: LocationFilter?
    var ticketPrice: TicketPriceFilter?
    var dateRange: DateRangeFilter?
    
    var searchFilter: SearchFilters? {
        let locationFilter: LocationSearchInput?
        let dateRangeFilter: DateRangeSearchInput?
        var ticketPriceFilter: [TicketPriceSearchInput]?
        
        if let location = location {
            locationFilter = LocationSearchInput(userLongitude: location.longitude, userLatitude: location.latitude, radius: location.radius)
        } else { locationFilter = nil }
        
        if let dateRange = dateRange {
            dateRangeFilter = DateRangeSearchInput(start: backendDateFormatter.string(from: dateRange.min), end: backendDateFormatter.string(from: dateRange.max))
        } else { dateRangeFilter = nil }
        
        if let ticketRange = ticketPrice {
            ticketPriceFilter = [TicketPriceSearchInput(minPrice: ticketRange.min, maxPrice: ticketRange.max)]
        } else { ticketPriceFilter = nil }
        
        if index == nil && locationFilter == nil && dateRangeFilter == nil && ticketPriceFilter == nil && (tags == nil || tags?.count == 0) {
            return nil
        }
        
        return SearchFilters(index: index, location: locationFilter, tags: self.tags?.map({ $0.title }), ticketPrice: ticketPriceFilter, dateRange: dateRangeFilter)
    }
}

struct TicketPriceFilter: Codable {
    init(ticketFilter: (Int, Int)) {
        self.min = ticketFilter.0
        self.max = ticketFilter.1
    }
    
    var min: Int
    var max: Int
}

struct DateRangeFilter: Codable {
    init(dateRange: (Date, Date)) {
        self.min = dateRange.0
        self.max = dateRange.1
    }
    
    var min: Date
    var max: Date
}
