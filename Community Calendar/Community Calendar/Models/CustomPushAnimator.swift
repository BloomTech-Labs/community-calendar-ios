 //
 //  CustomPushAnimator.swift
 //  Community Calendar
 //
 //  Created by Jordan Christensen on 1/15/20.
 //  Copyright © 2020 Mazjap Co. All rights reserved.
 //
 
 import Foundation
 import UIKit
 
 // This class creates a custom animation when a push segue is used in tandem with a navigation controller
 class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    init(view: UIView) {
        self.navView = view
    }
    
    let navView: UIView
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to),
            let toView = toViewController.view, let fromView = fromViewController.view else { return }
        transitionContext.containerView.addSubview(toView)
        toView.layer.cornerRadius = backgroundViewCornerRad
        fromView.layer.cornerRadius = foregroundViewCornerRad
        
        let fadeView: UIView
        if let viewWithFadeTag = fromView.viewWithTag(fadeViewTag) {
            viewWithFadeTag.isHidden = false
            viewWithFadeTag.frame = toView.frame
            fadeView = viewWithFadeTag
        } else {
            let tempFadeView = UIView()
            tempFadeView.tag = fadeViewTag
            fromView.addSubview(tempFadeView)
            tempFadeView.frame = toView.frame
            tempFadeView.layer.cornerRadius = backgroundViewCornerRad
            fadeView = tempFadeView
        }
        toView.frame = CGRect(x: self.navView.frame.minX, y: self.navView.frame.maxY, width: self.navView.frame.width, height: self.navView.frame.height - 47)
        
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            fromView.frame = vcFrameRect(from: self.navView)
            fadeView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: fromView.frame.size)
            fadeView.backgroundColor = .transparentLightGrey
            toView.superview?.layoutIfNeeded()
            fromView.superview?.layoutIfNeeded()
            toView.frame = CGRect(x: self.navView.frame.minX, y: self.navView.frame.minY + 47, width: self.navView.frame.size.width, height: self.navView.frame.size.height - 47)
        }, completion: { _ in
            // Mark transition as complete unless cancelled and allow user input once again
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            // Calling completeTransition removes the fromView from the view stack, so we insert the same instance of the home view controller into the window to be able to see it in the background
            // Note that this instance will be removed again when VC is popped
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.insertSubview(fromView, at: 0)
            
            fromView.frame = vcFrameRect(from: self.navView)
        })
    }
 }
