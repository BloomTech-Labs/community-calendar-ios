//
//  DropDownTextField.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/28/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import UIKit

@IBDesignable
class DropDownTextField: UITextField {

    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            context.setLineWidth(2)
            
            context.move(to: CGPoint(x: rect.width - 1, y: rect.height/2 - 3))
            context.addLine(to: CGPoint(x: rect.width - 5.5, y: rect.height/2 + 3))
            context.setStrokeColor(UIColor.black.cgColor)
            context.strokePath()
            
            context.move(to: CGPoint(x: rect.width - 5, y: rect.height/2 + 3))
            context.addLine(to: CGPoint(x: rect.width - 9.5, y: rect.height/2 - 3))
            context.setStrokeColor(UIColor.black.cgColor)
            context.strokePath()
            
            context.move(to: CGPoint(x: 0, y: 20))
            context.setLineWidth(1)
            context.addLine(to: CGPoint(x: frame.width, y: 20))
            context.setStrokeColor(UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1).cgColor)
            context.strokePath()
        }
    }
}
