//
//  UIColor+Extension.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/16/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import UIKit

extension UIColor {
    // TODO: - Move all colors here instead of re-initializing them each time
    static let selectedButton = UIColor(red: 0.13, green: 0.14, blue: 0.17, alpha: 1.0)
    static let unselectedButton = UIColor(red: 0.77, green: 0.77, blue: 0.77, alpha: 1.0)
    static let unselectedDayButton = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    static let tabBarTint = UIColor(red: 1.0, green: 0.4, blue: 0.41, alpha: 1.0)
    static let transparentLightGray = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 0.4)
    static let coral = UIColor(displayP3Red: 0.7410163879, green: 0.4183317125, blue: 0.4147843719, alpha: 1)
    static let coralSubtleGradient = UIColor(displayP3Red: 0.5843137255, green: 0.2235294118, blue: 0.2352941176, alpha: 1)
    
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}
