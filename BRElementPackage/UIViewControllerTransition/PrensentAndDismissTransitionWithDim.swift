//
//  PrensentAndDismissTransitionWithDim.swift
//  BRElementPackage
//
//  Created by i9400503 on 2020/1/21.
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit

class DimFullView : UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        self.alpha = 0
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PresendAndDismissTransition : NSObject , UIViewControllerAnimatedTransitioning{

    private var isDismiss:Bool!

    convenience  init(isDismiss : Bool) {
        self.init()
        self.isDismiss = isDismiss
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to) ,
            let fromVC = transitionContext.viewController(forKey: .from) else {return}

        //present
        if !isDismiss{
            toVC.view.frame.size.height -= 50
            toVC.view.frame.origin.y = UIScreen.main.bounds.height
            transitionContext.containerView.addSubview(toVC.view)

            let toViewpath = UIBezierPath(roundedRect: toVC.view.bounds, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 6, height: 6))

            let toViewmask = CAShapeLayer()
            toViewmask.path = toViewpath.cgPath
            toVC.view.layer.mask = toViewmask

            let fromViewPath = UIBezierPath(roundedRect: fromVC.view.bounds, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 6, height: 6))

            let fromViewMask = CAShapeLayer()
            fromViewMask.path = fromViewPath.cgPath
            fromVC.view.layer.mask = fromViewMask

            let dimview = DimFullView(frame: fromVC.view.frame)

            transitionContext.containerView.insertSubview(dimview, belowSubview: toVC.view)

            fromVC.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)

            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [.curveLinear], animations: {
                dimview.alpha = 0.7
                fromVC.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                toVC.view.frame.origin.y = 50
            }) { _ in
                fromVC.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }else{
            //dismiss
            let dimmingView = transitionContext.containerView.subviews.first(where: { (view) -> Bool in
                return view is DimFullView
            })

            fromVC.view.frame.origin.y = 50

            let fromViewSnpaShot = fromVC.view.snapshotView(afterScreenUpdates: false)

            if let fromviewShapShot = fromViewSnpaShot{
                fromVC.view.isHidden = true
                fromviewShapShot.frame = fromVC.view.frame
                transitionContext.containerView.addSubview(fromviewShapShot)
            }

            dimmingView?.alpha = 0.7

            toVC.view.transform = CGAffineTransform(scaleX: 0.9, y:0.9)

            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [.curveLinear], animations: {
                dimmingView?.alpha = 0
                fromViewSnpaShot?.frame.origin.y = UIScreen.main.bounds.size.height
                toVC.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)

            }) { _ in
                if !transitionContext.transitionWasCancelled{
                    toVC.view.transform = .identity
                    dimmingView?.removeFromSuperview()
                    toVC.view.layer.mask = nil
                }
                fromViewSnpaShot?.removeFromSuperview()
                fromVC.view.isHidden = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }

        }

    }


}
