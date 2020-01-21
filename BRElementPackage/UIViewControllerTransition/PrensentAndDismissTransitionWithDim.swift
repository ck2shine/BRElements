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
            //make the present view be more texture
            toVC.view.frame.size.height -= 50
            toVC.view.frame.origin.y = UIScreen.main.bounds.height
            transitionContext.containerView.addSubview(toVC.view)

            //add layer to make the view is drawn with rounded corner
            let toViewpath = UIBezierPath(roundedRect: toVC.view.bounds, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 6, height: 6))

            let toViewmask = CAShapeLayer()
            toViewmask.path = toViewpath.cgPath
            toVC.view.layer.mask = toViewmask
            
            let fromViewPath = UIBezierPath(roundedRect: fromVC.view.bounds, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 6, height: 6))

            let fromViewMask = CAShapeLayer()
            fromViewMask.path = fromViewPath.cgPath
            fromVC.view.layer.mask = fromViewMask

            let dimview = DimFullView(frame: fromVC.view.frame)

            //add a dimView between toView and fromView
            transitionContext.containerView.insertSubview(dimview, belowSubview: toVC.view)
            
            //basic form before transition
            fromVC.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)

            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [.curveLinear], animations: {
                dimview.alpha = 0.7
                fromVC.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                toVC.view.frame.origin.y = 50 //from down to 50 show  sky space
            }) { _ in
                fromVC.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }else{
            //dismiss
            //first find dimView
            let dimmingView = transitionContext.containerView.subviews.first(where: { (view) -> Bool in
                return view is DimFullView
            })
            
            //setting the original trasition origin of y
            fromVC.view.frame.origin.y = 50

            //make a screen shot of from view
            let fromViewSnpaShot = fromVC.view.snapshotView(afterScreenUpdates: false)

            
            if let fromviewShapShot = fromViewSnpaShot{
                fromVC.view.isHidden = true //because we use snapShot and add it in the container view , thus we need to hide the from view
                fromviewShapShot.frame = fromVC.view.frame
                transitionContext.containerView.addSubview(fromviewShapShot)
            }

            //original status of dimView
            dimmingView?.alpha = 0.7
            
            //to view is the view who presented the from view , so make the view become scale size in 0.9 , we will soon let it back to size of 1.0
            toVC.view.transform = CGAffineTransform(scaleX: 0.9, y:0.9)

            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [.curveLinear], animations: {
                dimmingView?.alpha = 0
                fromViewSnpaShot?.frame.origin.y = UIScreen.main.bounds.size.height
                toVC.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)

            }) { _ in
                if !transitionContext.transitionWasCancelled{
                    //back to the status without any transform , .identity
                    toVC.view.transform = .identity
                    dimmingView?.removeFromSuperview()//remove dim view
                    toVC.view.layer.mask = nil //remove shape layer
                }
                //remove snapsht
                fromViewSnpaShot?.removeFromSuperview()
                fromVC.view.isHidden = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }

        }

    }


}
