//
//  UIView+GradientLayer.swift
//  Community Calendar
//
//  Created by Michael on 5/24/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

extension UIView {
    func addGradient(color1: UIColor, color2: UIColor) {
        let gradientlayer = CAGradientLayer()
        gradientlayer.colors = [color1.cgColor, color2.cgColor]
        gradientlayer.locations = [0.0, 1.0]
        gradientlayer.frame = bounds
        gradientlayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientlayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        layer.insertSublayer(gradientlayer, at: 0)
    }
    
    func addGradientToButton(color1: UIColor, color2: UIColor) {
        let gradientlayer = CAGradientLayer()
        gradientlayer.colors = [color1.cgColor, color2.cgColor]
        gradientlayer.locations = [0.0, 1.0]
        gradientlayer.frame = bounds
        gradientlayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientlayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        layer.insertSublayer(gradientlayer, at: 0)
    }
    
    func add3ColorGradient(color1: UIColor, color2: UIColor, color3: UIColor) {
        let gradientlayer = CAGradientLayer()
        gradientlayer.colors = [color1.cgColor, color2.cgColor, color3.cgColor]
        gradientlayer.locations = [0.15, 0.5, 0.85]
        gradientlayer.frame = bounds
        gradientlayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientlayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        layer.insertSublayer(gradientlayer, at: 0)
    }
    
    func weirdLineGradient(color1: UIColor, color2: UIColor, color3: UIColor) {
        let gradientlayer = CAGradientLayer()
        gradientlayer.colors = [color1.cgColor, color2.cgColor, color3.cgColor]
        gradientlayer.locations = [0.0, 0.5, 1.0]
        gradientlayer.frame = bounds
        gradientlayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientlayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        layer.insertSublayer(gradientlayer, at: 0)
    }
    
    func add4ColorGradient(color1: UIColor, color2: UIColor, color3: UIColor, color4: UIColor) {
        let gradientlayer = CAGradientLayer()
        gradientlayer.colors = [color1.cgColor, color2.cgColor, color3.cgColor, color4.cgColor]
        gradientlayer.locations = [0.0, 0.15, 0.85, 1.0]
        gradientlayer.frame = bounds
        gradientlayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientlayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        layer.insertSublayer(gradientlayer, at: 0)
    }
}
