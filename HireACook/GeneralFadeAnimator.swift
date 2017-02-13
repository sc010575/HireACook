//
//  GeneralFadeAnimator.swift
//  HireACook
//
//  Created by Suman Chatterjee on 22/04/2016.
//  Copyright © 2016 Suman Chatterjee. All rights reserved.
//

import UIKit

@objc class GeneralFadeAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return duration;
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()
        
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        containerView.addSubview(toView)
        toView.alpha = 0.0

        UIView.animateWithDuration(duration, animations: {
            toView.alpha = 1.0
            }, completion: { _ in
                transitionContext.completeTransition(true) })
    }

}
