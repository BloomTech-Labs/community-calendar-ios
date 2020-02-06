//
//  CustomPushAnimator.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/15/20.
//  Copyright © 2020 Mazjap Co. All rights reserved.
//
// 

import Foundation
import UIKit

class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    init(view: UIView) {
        self.navView = view
    }
    
    let navView: UIView
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval { return 0.35 }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to) as? FilterViewController, let toView = toViewController.view, let fromView = fromViewController.view else { return }
        transitionContext.containerView.addSubview(toView)
        toView.layer.cornerRadius = backgroundViewCornerRad
        fromView.layer.cornerRadius = foregroundViewCornerRad
        
        let fadeView: UIView // if view with tag "123" exists, fetch it, if not, create it
        if let viewWithFadeTag = fromView.viewWithTag(fadeViewTag) {
            viewWithFadeTag.isHidden = false
            fadeView = viewWithFadeTag
        } else {
            let tempFadeView = UIView()
            tempFadeView.tag = fadeViewTag
            fromView.addSubview(tempFadeView)
            tempFadeView.frame = fromView.frame
            tempFadeView.layer.cornerRadius = backgroundViewCornerRad
            fadeView = tempFadeView
        }
        toView.frame = CGRect(origin: CGPoint(x: 0, y: navView.frame.height), size: navView.frame.size)
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            fromView.transform = CGAffineTransform(scaleX: 0.925, y: 0.9)
            miniFrame = fromView.frame
//            fadeView.backgroundColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 0.4)
            fadeView.backgroundColor = .transparentLightGray
            fadeView.superview?.layoutIfNeeded()
            toView.transform = CGAffineTransform(translationX: 0, y: -self.navView.frame.height * 0.94)
        }, completion: { _ in
            // Mark transition as complete unless cancelled and allow user input once again
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            // Calling completeTransition removes the fromView from the view stack, so we insert the same instance of the home view controller into the window to be able to see it in the background
            // Note that this instance will be removed again when VC is popped
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.insertSubview(fromView, at: 0)
            fromView.frame = miniFrame
            fromView.superview?.layoutIfNeeded()
            fromView.transform = CGAffineTransform(scaleX: 0.925, y: 0.9)
        })
    }
}
