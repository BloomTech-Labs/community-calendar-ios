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

let fadeViewTag = 123
let backgroundViewCornerRad: CGFloat = 10
let foregroundViewCornerRad: CGFloat = 15
var returnRadius: CGFloat { isRoundedDevice() }

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
    df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    return df
}()

let filterDateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "MM-dd-yy"
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
