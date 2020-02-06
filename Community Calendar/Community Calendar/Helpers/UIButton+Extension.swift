//
//  UIButton+Extension.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 2/4/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

extension UIButton { // Set title for all button states
    func text(_ title: String) {
        for state: UIControl.State in [.normal, .highlighted, .disabled, .selected, .focused, .application, .reserved] {
            self.setTitle(title, for: state)
        }
    }
    
    func attrText(_ title: String, font: UIFont = UIFont(name: "Poppins-Regular", size: 14)!, color: UIColor = .black) {
        let text = NSAttributedString(string: title, attributes:
            [NSAttributedString.Key.font : font,
             NSAttributedString.Key.foregroundColor : color])
        for state: UIControl.State in [.normal, .highlighted, .disabled, .selected, .focused, .application, .reserved] {
            self.setAttributedTitle(text, for: state)
        }
    }
}
