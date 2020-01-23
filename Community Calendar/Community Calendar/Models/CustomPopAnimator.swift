//
//  CustomPopAnimator.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/15/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//

import Foundation
import UIKit

// This class creates a custom animation when a push segue is popped off the view stack. Used in tandem with a navigation controller
class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    init(view: UIView) {
        self.navView = view
    }
    
    let navView: UIView // Used as a UIViewController size reference
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35 // Set duration of animation
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // Create a reference to the view controller that was being displayed and the view controller that will be displayed
        guard let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to),
            let toView = toViewController.view, let fromView = fromViewController.view else { return }
        transitionContext.containerView.insertSubview(toView, belowSubview: fromView)
        toView.layer.cornerRadius = foregroundViewCornerRad
        fromView.layer.cornerRadius = backgroundViewCornerRad
        
        // Turn off translatesAutoresizingMaskIntoConstraints to be able to set custom constraints programmatically
        
        let duration = self.transitionDuration(using: transitionContext)
        toView.transform = CGAffineTransform(scaleX: 0.925, y: 0.9)
        toView.superview?.layoutIfNeeded()
        fromView.frame = CGRect(x: self.navView.frame.minX, y: self.navView.frame.minY + 47, width: self.navView.frame.size.width, height: self.navView.frame.size.height - 47)
        
        var fadeView: UIView?
        UIView.animate(withDuration: duration, animations: {
            fromView.frame = CGRect(x: self.navView.frame.minX, y: self.navView.frame.maxY, width: self.navView.frame.width, height: self.navView.frame.height - 47)
            toView.transform = CGAffineTransform(scaleX: 1, y: 1)
            if let viewWithFadeTag = toView.viewWithTag(fadeViewTag) {
                viewWithFadeTag.backgroundColor = .clear
                fadeView = viewWithFadeTag
                toView.layer.cornerRadius = returnRadius
            }
            fadeView?.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            fadeView?.isHidden = true
            toView.layer.cornerRadius = 0
        })
    }
}
