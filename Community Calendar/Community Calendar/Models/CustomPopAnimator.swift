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
        return 0.35 // Setting duration of animation
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // Create a reference to the view controller that was being displayed and the view controller that will be displayed
        guard let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to),
            let toView = toViewController.view, let fromView = fromViewController.view else { return }
        transitionContext.containerView.insertSubview(toView, belowSubview: fromView)
        toView.layer.cornerRadius = viewControllerBorderRadius
        fromView.layer.cornerRadius = viewControllerBorderRadius
        
        if let viewWithFadeTag = toView.viewWithTag(fadeViewTag) {
            viewWithFadeTag.isHidden = true
        }
        
        // Turn off translatesAutoresizingMaskIntoConstraints to be able to set custom constraints programmatically
        fromView.translatesAutoresizingMaskIntoConstraints = false
        
        let duration = self.transitionDuration(using: transitionContext)
        toView.frame = vcFrameRect(from: navView)
        toView.superview?.layoutIfNeeded()
        // Set fromView's constraint's to be the same as the navView, aside from the top which needs to be 41px lower
        constraint(firstView: fromView, to: self.navView).first?.isActive = false
        let topConst = NSLayoutConstraint(item: fromView, attribute: .top, relatedBy: .equal, toItem: navView, attribute: .top, multiplier: 1, constant: 47); topConst.isActive = true
        fromView.superview?.layoutIfNeeded()
        topConst.isActive = false
        
        let topToBotConst = NSLayoutConstraint(item: fromView, attribute: .top, relatedBy: .equal, toItem: navView, attribute: .bottom, multiplier: 1, constant: 0); topToBotConst.isActive = true
        
        let leftConst = NSLayoutConstraint(item: fromView, attribute: .left, relatedBy: .equal, toItem: navView, attribute: .left, multiplier: 1, constant: 0); leftConst.isActive = true
        let rightConst = NSLayoutConstraint(item: fromView, attribute: .right, relatedBy: .equal, toItem: navView, attribute: .right, multiplier: 1, constant: 0); rightConst.isActive = true
        toView.superview?.layoutIfNeeded()
        
        let botConst = NSLayoutConstraint(item: fromView, attribute: .bottom, relatedBy: .equal, toItem: navView, attribute: .bottom, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([topToBotConst, botConst, rightConst, leftConst])
        UIView.animate(withDuration: duration, animations: {
            fromView.superview?.layoutIfNeeded()
            toView.frame = self.navView.frame
//            toView.
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
