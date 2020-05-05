//
//  UIView+DropShadow.swift
//  Community Calendar
//
//  Created by Michael on 4/24/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import UIKit

extension UIView {
    func dropShadow(scale: Bool = true) {
        
        layer.masksToBounds = false
        
        layer.shadowColor = UIColor.black.cgColor
        
        layer.shadowOpacity = 0.5
        
        layer.shadowOffset = CGSize(width: 0, height: 0)
        
        layer.shadowRadius = 5
        
        layer.shouldRasterize = true
        
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
