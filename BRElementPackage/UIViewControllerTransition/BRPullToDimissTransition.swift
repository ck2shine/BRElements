//
//  BRPullToDimissTransition.swift
//  BRElementPackage
//
//  Created by Shine on 2020/1/20.
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit
class BRPullToDimissTransition : UIPercentDrivenInteractiveTransition{
    
    private var interactiveView : UIView?
    
    private var presenter : UIViewController?
    
    private let thredhold : CGFloat = 0.4

    private var completion : (()->())?
    
    convenience init(_ presenter : UIViewController , _ interactiveView : UIView , _ completion : (()->())? = nil) {
        self.init()
        self.interactiveView = interactiveView
        self.presenter = presenter
        self.completion = completion
        setupGesture()

         wantsInteractiveStart = false
    }
    
    private func setupGesture(){
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlerPanEvent(_:)))
        panGesture.maximumNumberOfTouches = 1
        panGesture.delegate = self
        interactiveView?.addGestureRecognizer(panGesture)
        

    }
    
    
    @objc func handlerPanEvent(_ sender : UIPanGestureRecognizer){
        switch sender.state {
        case .began:
            sender.setTranslation(.zero, in: interactiveView)

            wantsInteractiveStart = true

            //tell system do the trasition , it won`t start immediately , system will capture the action
            presenter?.dismiss(animated: true, completion: nil)
        case .changed:

            //change is purpose to change complete percentage
            let translation = sender.translation(in: interactiveView)

            guard translation.y >= 0 else {
                sender.setTranslation(.zero, in: interactiveView)
                return
            }

            let persentage = abs(translation.y / (interactiveView?.bounds.height)!)

            //animation percentage
            update(persentage)


        case .ended:


            if percentComplete >= thredhold {
                finish()
            }else{
                //close animation
                wantsInteractiveStart = false
                cancel()
            }
        case .cancelled,.failed:
            wantsInteractiveStart = false
            cancel()
        default:
            wantsInteractiveStart = false
            return
        }
    }
}

//if view contains a scroll , then start interaction transition ,
extension BRPullToDimissTransition : UIGestureRecognizerDelegate{

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
           if let scrollView = otherGestureRecognizer.view as? UIScrollView {
               if scrollView.contentOffset.y <= 0 {
                   return true
               } else {
                   return false
               }
           }
           return true
       }

}
