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
        toView.layer.cornerRadius = viewControllerBorderRadius
        fromView.layer.cornerRadius = viewControllerBorderRadius
        
        toView.translatesAutoresizingMaskIntoConstraints = false
        let fadeView: UIView
        if let viewWithFadeTag = fromView.viewWithTag(fadeViewTag) {
            viewWithFadeTag.isHidden = false
            viewWithFadeTag.backgroundColor = .transparentLightGrey
            viewWithFadeTag.frame = toView.frame
            fadeView = viewWithFadeTag
        } else {
            let tempFadeView = UIView()
            tempFadeView.tag = fadeViewTag
            fromView.addSubview(tempFadeView)
            tempFadeView.backgroundColor = .transparentLightGrey
            tempFadeView.frame = toView.frame
            tempFadeView.layer.cornerRadius = viewControllerBorderRadius
            fadeView = tempFadeView
        }
    
        let topToBotConst = NSLayoutConstraint(item: toView, attribute: .top, relatedBy: .equal, toItem: navView, attribute: .bottom, multiplier: 1, constant: 0); topToBotConst.isActive = true
        
        let leftConst = NSLayoutConstraint(item: toView, attribute: .left, relatedBy: .equal, toItem: navView, attribute: .left, multiplier: 1, constant: 0); leftConst.isActive = true
        let rightConst = NSLayoutConstraint(item: toView, attribute: .right, relatedBy: .equal, toItem: navView, attribute: .right, multiplier: 1, constant: 0); rightConst.isActive = true
        toView.superview?.layoutIfNeeded()
        
        let botConst = NSLayoutConstraint(item: toView, attribute: .bottom, relatedBy: .equal, toItem: navView, attribute: .bottom, multiplier: 1, constant: 0)
        constraint(firstView: fromView, to: self.navView)
        let topConst = NSLayoutConstraint(item: toView, attribute: .top, relatedBy: .equal, toItem: navView, attribute: .top, multiplier: 1, constant: 47)
        
        NSLayoutConstraint.activate([topConst, botConst, rightConst, leftConst])
        
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            fromView.frame = vcFrameRect(from: self.navView)
            fadeView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: fromView.frame.size)
            toView.superview?.layoutIfNeeded()
            fromView.superview?.layoutIfNeeded()
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
