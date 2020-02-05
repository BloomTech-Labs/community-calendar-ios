//
//  UIButton+Extension.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 2/4/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

extension UIButton {
    func text(_ title: String) {
        for state: UIControl.State in [.normal, .highlighted, .disabled, .selected, .focused, .application, .reserved] {
            self.setTitle(title, for: state)
        }
    }
}
