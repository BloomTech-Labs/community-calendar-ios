//
//  CustomPopAnimator.swift
//  Community Calendar
//
//  Created by Jordan Christensen on 1/15/20.
//  Copyright © 2020 Lambda School All rights reserved.
//

import Foundation
import UIKit

// This class creates a custom animation. Reference CustomPushAnimator.swift for more info
// BUG: fadeView does not resize with toView
class CustomPopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    init(view: UIView) {
        self.navView = view
    }
    
    let navView: UIView
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // toVC and fromVC are oposite to what they are in CustomPushAnimator.swift
        guard let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to) as? HomeViewController,
            let toView = toViewController.view, let fromView = fromViewController.view else { return }
        toViewController.shouldDismissFilterScreen = false
        transitionContext.containerView.insertSubview(toView, belowSubview: fromView)
        toView.layer.cornerRadius = foregroundViewCornerRad
        fromView.layer.cornerRadius = backgroundViewCornerRad
        
        toView.frame = miniFrame
        toView.superview?.layoutIfNeeded()
        fromView.frame = CGRect(x: self.navView.frame.minX, y: self.navView.frame.minY + 47, width: self.navView.frame.size.width, height: self.navView.frame.size.height - 47)
        
        var fadeView: UIView?
        if let viewWithFadeTag = toView.viewWithTag(fadeViewTag) {
            fadeView = viewWithFadeTag
        }
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            fromView.frame = CGRect(x: self.navView.frame.minX, y: self.navView.frame.maxY, width: self.navView.frame.width, height: self.navView.frame.height - 47)
            toView.transform = CGAffineTransform.identity
            fadeView?.layer.backgroundColor = UIColor.clear.cgColor
            toView.layer.cornerRadius = returnRadius
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            fadeView?.isHidden = true
            toView.layer.cornerRadius = 0
        })
    }
}


//Push is working correctly, but pop is causing issues, fade view either isn't displaying or just not changing background color
