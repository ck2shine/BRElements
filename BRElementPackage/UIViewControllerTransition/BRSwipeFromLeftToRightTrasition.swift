//
//  BRSwipeFromLeftToRightTrasition.swift
//  BRElementPackage
//
//  Created by Shine on 2020/1/21.
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit
class BRSwipeFromLeftToRightTrasition : NSObject , UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to) , let fromView = transitionContext.view(forKey: .from) else {
            return
        }
        
        //original status
        toView.frame.origin.x = -(UIScreen.main.bounds.width / 2)
        fromView.frame.origin.x = 0
        
        transitionContext.containerView.insertSubview(toView, belowSubview: fromView)
        
        let shadowRect : CGRect = CGRect(x: -4, y: -20, width: 4, height: fromView.frame.height)
        let shadowPath = UIBezierPath(rect: shadowRect)
        fromView.layer.shadowPath = shadowPath.cgPath
        fromView.layer.shadowOpacity = 0.8
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [.curveLinear], animations: {
            toView.frame.origin.x = 0
            fromView.frame.origin.x = UIScreen.main.bounds.width
        }) { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }        
    }
    
    
}
