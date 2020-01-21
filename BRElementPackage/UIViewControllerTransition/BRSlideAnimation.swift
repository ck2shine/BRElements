//
//  BRSlideAnimation.swift
//  BRElementPackage
//
//  Created by i9400503 on 2020/1/20.
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation
import UIKit
class BRSlideFromLeftToRightTransition: NSObject , UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        //use view from transitionContext.view
        let toView  = transitionContext.view(forKey: .to)
        let toVC = transitionContext.viewController(forKey: .to)
        let toInitFrame = transitionContext.initialFrame(for: toVC!)
        let toFinalFrame = transitionContext.finalFrame(for: toVC!)
        
        
        let fromView  = transitionContext.view(forKey: .from)
        let fromVC = transitionContext.viewController(forKey: .from)
        let fromInitFrame = transitionContext.initialFrame(for: fromVC!)
        let fromfinalFrame = transitionContext.finalFrame(for: fromVC!)


        UIView.animate(withDuration:  transitionDuration(using: transitionContext), delay: 0, options: [.curveLinear], animations: {
            if !transitionContext.transitionWasCancelled{

            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }


}
