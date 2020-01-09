//
//  Colors.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 12/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

import UIKit
import CoreData

//extension NSManagedObjectContext {
//    static let mainContext = CoreDataStack.shared.mainContext
//}

extension UIColor {
    static let selectedButton = UIColor(red: 0.13, green: 0.14, blue: 0.17, alpha: 1.0)
    static let unselectedButton = UIColor(red: 0.77, green: 0.77, blue: 0.77, alpha: 1.0)
    static let unselectedDayButton = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    static let tabBarTint = UIColor(red: 1.0, green: 0.4, blue: 0.41, alpha: 1.0)
}

let todayDateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "EEEE, MMMM d, yyyy"
    return df
}()

let featuredEventDateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "MMMM d, EEEE"
    return df
}()

let cellDateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "h:mma"
    return df
}()

let backendDateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return df
}()

enum NetworkError: Error {
    case encodingError
    case responseError
    case noData
    case badDecode
    case noToken // No bearer token
    case otherError(Error)
}
