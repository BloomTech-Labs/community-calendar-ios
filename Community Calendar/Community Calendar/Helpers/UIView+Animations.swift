//
//  UIView+Animations.swift
//  Community Calendar
//
//  Created by Michael on 5/28/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

extension UIView {
    
    func springIn() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.5
        pulse.fromValue = 0.8
        pulse.toValue = 1.5
        pulse.autoreverses = false
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
    
    func springOut() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.5
        pulse.fromValue = 1.0
        pulse.toValue = 0.1
        pulse.autoreverses = false
        pulse.repeatCount = 0
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
    
    func loginSpring() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.5
        pulse.fromValue = 0.8
        pulse.toValue = 1.2
        pulse.autoreverses = false
        pulse.repeatCount = 0
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
}

