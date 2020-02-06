//
//  Date+Extension.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/29/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import Foundation

extension Date { // Make dates easier to use
    func getWeekDays() -> (thisWeek:[Date], nextWeek:[Date]) {
        var tuple: (thisWeek:[Date], nextWeek:[Date])
        var arrThisWeek: [Date] = []
        for i in 0..<7 {
            arrThisWeek.append(Calendar.current.date(byAdding: .day, value: i, to: startOfWeek)!)
        }
        var arrNextWeek: [Date] = []
        for i in 1...7 {
            arrNextWeek.append(Calendar.current.date(byAdding: .day, value: i, to: arrThisWeek.last!)!)
        }
        tuple = (thisWeek: arrThisWeek, nextWeek: arrNextWeek)
        return tuple
    }

    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }

    var startOfWeek: Date {
        let gregorian = Calendar(identifier: .gregorian)
        let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
        return gregorian.date(byAdding: .day, value: 1, to: sunday!)!
    }

    func toDate(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func isEqual(to date: Date) -> Bool {
        return Calendar.current.dateComponents([.day, .month, .year], from: date) == Calendar.current.dateComponents([.day, .month, .year], from: self)
    }
    
    func isGreaterThan(date: Date) -> Bool? {
        // Convert date to string and back to get date representented by only day, month, and year so that if two dates are the same day, they'll return false
        let thisString = filterDateFormatter.string(from: self)
        let thatString = filterDateFormatter.string(from: date)
        guard let this = filterDateFormatter.date(from: thisString),
            let that = filterDateFormatter.date(from: thatString) else { return nil }
        return this > that
    }
    
    func isLessThan(date: Date) -> Bool? {
        let thisString = filterDateFormatter.string(from: self)
        let thatString = filterDateFormatter.string(from: date)
        guard let this = filterDateFormatter.date(from: thisString),
            let that = filterDateFormatter.date(from: thatString) else { return nil }
        return this < that
    }
}
