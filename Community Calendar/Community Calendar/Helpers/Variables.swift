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
    static let transparentLightGrey = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 0.3)
}

extension Notification.Name {
    static var imageWasLoaded: Notification.Name {
        .init(rawValue: "EventController.imageWasLoaded")
    }
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
    df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    return df
}()

let fadeViewTag = 123

let viewControllerBorderRadius: CGFloat = 20.0

func vcFrameRect(from navView: UIView) -> CGRect {
    return CGRect(x: navView.frame.maxX * 0.025, y: navView.frame.maxY * 0.04, width: navView.frame.size.width * 0.95, height: navView.frame.size.height * 0.9)
}

enum NetworkError: Error {
    case encodingError
    case responseError
    case noData
    case badDecode
    case noToken // No bearer token
    case otherError(Error)
}

@discardableResult func constraint(firstView: UIView, to secondView: UIView, top: NSLayoutConstraint? = nil, bot: NSLayoutConstraint? = nil, left: NSLayoutConstraint? = nil, right: NSLayoutConstraint? = nil) -> [NSLayoutConstraint] {
    let topConst: NSLayoutConstraint
    let botConst: NSLayoutConstraint
    let leftConst: NSLayoutConstraint
    let rightConst: NSLayoutConstraint
    
    if let top = top {
        topConst = top
    } else {
        topConst = NSLayoutConstraint(item: firstView, attribute: .top, relatedBy: .equal, toItem: secondView, attribute: .top, multiplier: 1, constant: 0)
    }
    
    if let left = left {
        leftConst = left
    } else {
        leftConst = NSLayoutConstraint(item: firstView, attribute: .left, relatedBy: .equal, toItem: secondView, attribute: .left, multiplier: 1, constant: 0)
    }
    
    if let right = right {
        rightConst = right
    } else {
        rightConst = NSLayoutConstraint(item: firstView, attribute: .right, relatedBy: .equal, toItem: secondView, attribute: .right, multiplier: 1, constant: 0)
    }
    
    if let bot = bot {
        botConst = bot
    } else {
        botConst = NSLayoutConstraint(item: firstView, attribute: .bottom, relatedBy: .equal, toItem: secondView, attribute: .bottom, multiplier: 1, constant: 0)
    }
    
    let constArr = [topConst, leftConst, rightConst, botConst]
    NSLayoutConstraint.activate(constArr)
    
    firstView.superview?.layoutIfNeeded()
    return constArr
}
