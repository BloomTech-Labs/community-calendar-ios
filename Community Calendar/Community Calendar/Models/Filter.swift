//
//  Filter.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/28/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import Foundation

struct Filter: Codable, Equatable {
    init(index: String? = nil, tags: [Tag]? = nil, location: LocationFilter? = nil, zipCode: Int? = nil, ticketPrice: (Int, Int)? = nil, dateRange: (Date, Date)? = nil) {
        self.index = index
        self.tags = tags
        self.location = location
        self.zipCode = zipCode
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
    var zipCode: Int?
    var ticketPrice: TicketPriceFilter?
    var dateRange: DateRangeFilter?
    
//    var searchFilter: SearchFilters? {
//        let locationFilter: LocationSearchInput?
//        let dateRangeFilter: DateRangeSearchInput?
//        var ticketPriceFilter: [TicketPriceSearchInput]?
//
//        if let location = location {
//            locationFilter = LocationSearchInput(userLongitude: location.longitude, userLatitude: location.latitude, radius: location.radius)
//        } else { locationFilter = nil }
//
//        if let dateRange = dateRange {
//            dateRangeFilter = DateRangeSearchInput(start: backendDateFormatter.string(from: dateRange.min), end: backendDateFormatter.string(from: dateRange.max))
//        } else { dateRangeFilter = nil }
//
//        if let ticketRange = ticketPrice {
//            ticketPriceFilter = [TicketPriceSearchInput(minPrice: ticketRange.min, maxPrice: ticketRange.max)]
//        } else { ticketPriceFilter = nil }
//
//        if index == nil && locationFilter == nil && dateRangeFilter == nil && ticketPriceFilter == nil && (tags == nil || tags?.count == 0) {
//            return nil
//        }
//
//        return SearchFilters(index: index, location: locationFilter, tags: self.tags?.map({ $0.title }), ticketPrice: ticketPriceFilter, dateRange: dateRangeFilter)
//    }
    
    static func == (lhs: Filter, rhs: Filter) -> Bool {
        return lhs.index == rhs.index &&
            lhs.location == rhs.location &&
            lhs.dateRange == rhs.dateRange &&
            lhs.ticketPrice == rhs.ticketPrice &&
            lhs.tags == rhs.tags
    }
    
//    static func == (lhs: Filter, rhs: Filter?) -> Bool { // To check if object is nil
//        // Object can be initialized, but it will return true if the searchFilter is nil
//        if let rhs = rhs {
//            return lhs == rhs
//        } else {
//            return lhs.searchFilter != nil
//        }
//    }
}

struct TicketPriceFilter: Codable, Equatable {
    init(ticketFilter: (Int, Int)) {
        self.min = ticketFilter.0
        self.max = ticketFilter.1
    }
    
    var min: Int
    var max: Int
}

struct DateRangeFilter: Codable, Equatable {
    init(dateRange: (Date, Date)) {
        self.min = dateRange.0
        self.max = dateRange.1
    }
    
    var min: Date
    var max: Date
}
