//
//  UIView+DropShadow.swift
//  Community Calendar
//
//  Created by Michael on 4/24/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

extension UIView {
    
    func calendarShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.9
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 7
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func blackShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 3
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func profileImageViewShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = #colorLiteral(red: 0.1426353753, green: 0.2155658603, blue: 0.3295089006, alpha: 1)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 10
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func imageShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.opacity = 1.0
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 5
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func whiteShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 2
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func textShadow() {
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
        layer.shadowRadius = 2
        layer.shouldRasterize = true
    }
    
    func contactShadow() {
        let shadowSize: CGFloat = 20
        let contactRect = CGRect(x: -shadowSize, y: bounds.height - (shadowSize * 0.4), width: bounds.width + shadowSize * 2, height: shadowSize)
        layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.45
    }
    
    func floatingContactShadow() {
        let shadowSize: CGFloat = 10
        let shadowDistance: CGFloat = 30
        let contactRect = CGRect(x: shadowSize, y: bounds.height - (shadowSize * 0.4) + shadowDistance, width: bounds.width - shadowSize * 2, height: shadowSize)
        layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.4
    }
    
    func depthShadow() {
        let shadowRadius: CGFloat = 5
        let shadowWidth: CGFloat = 1.25
        let shadowHeight: CGFloat = 0.5
        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: shadowRadius / 2, y: bounds.height - shadowRadius / 2))
        shadowPath.addLine(to: CGPoint(x: bounds.width - shadowRadius / 2, y: bounds.height - shadowRadius / 2))
        shadowPath.addLine(to: CGPoint(x: bounds.width * shadowWidth, y: bounds.height + (bounds.height * shadowHeight)))
        shadowPath.addLine(to: CGPoint(x: bounds.width * -(shadowWidth - 1), y: bounds.height + (bounds.height * shadowHeight)))
        layer.shadowPath = shadowPath.cgPath
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.2
    }
    
    func gradientShadow1(scale: Bool = true) {
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowRadius = 5
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        
    }
    
    func gradientShadow2(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -3, height: -3)
        layer.shadowRadius = 5
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func settingsShadow(scale: Bool = true) {
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.9
        layer.shadowOffset = CGSize(width: 12, height: 12)
        layer.shadowRadius = 7
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func shadowGradientProfileImage() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.white.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.0, 0.5]
        gradient.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.masksToBounds = true
        let shadowLayer = CALayer()
        shadowLayer.frame = gradient.bounds
        shadowLayer.shadowColor = #colorLiteral(red: 0.1721869707, green: 0.1871494651, blue: 0.2290506661, alpha: 1)
        shadowLayer.shadowOpacity = 0.4
        shadowLayer.shadowRadius = 10
        shadowLayer.shadowPath = CGPath(rect: shadowLayer.bounds, transform: nil)

        gradient.cornerRadius = gradient.bounds.height / 2
        gradient.mask = shadowLayer
        layer.insertSublayer(gradient, at: 0)
//        layer.insertSublayer(gradient, below: layer)
    }
    
    func shadowGradientButton() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.white.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.0, 0.5]
        gradient.frame = CGRect(x: frame.minX - 20, y: frame.minY - 20, width: frame.width + 40, height: frame.height + 40)
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.masksToBounds = true
        let shadowLayer = CALayer()
        shadowLayer.frame = gradient.bounds
        shadowLayer.shadowColor = UIColor.gray.cgColor
        shadowLayer.shadowOpacity = 0.08
        shadowLayer.shadowRadius = 10
        shadowLayer.shadowPath = CGPath(rect: shadowLayer.bounds, transform: nil)
        
        gradient.cornerRadius = 8
        gradient.mask = shadowLayer
        layer.insertSublayer(gradient, below: layer)
    }
}
