//
//  Functions.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/16/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import UIKit

func vcFrameRect(from navView: UIView) -> CGRect {
    return CGRect(x: navView.frame.maxX * 0.0325, y: navView.frame.maxY * 0.04, width: navView.frame.size.width * 0.925, height: navView.frame.size.height * 0.9)
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

@discardableResult
func removeObject<T: Equatable>(_ object: T, from array: inout [T]) -> Any? {
    for index in 0...array.count - 1 {
        if object == array[index] {
            let temp = array[index]
            array.remove(at: index)
            return temp
        }
    }
    print("Failed to find object of type \(String(describing: object.self)) in array of type \(String(describing: array.self)). Are these objects of the same type?")
    return nil
}

func isRoundedDevice() -> CGFloat {
    switch UIDevice().type { // These devices have large bezels on the screen
    case .iPod1, .iPod2, .iPod3, .iPod4, .iPod5, .iPad2, .iPadMini1, .iPhone4,
         .iPhone4S, .iPhone5, .iPhone5C, .iPad3, .iPad4, .iPhone5S, .iPadAir1,
         .iPadAir2, .iPadMini2, .iPadMini3, .iPhone7plus, .iPhone6plus, .iPhone6,
         .iPhone6S, .iPhone6Splus, .iPhoneSE, .iPhone7, .iPhone8, .iPhone8plus:
        return 0
    default: // These devices have rounded screen corners
        return 35
    }
}
