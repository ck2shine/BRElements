//
//  BRSwipeToPopInteractive.swift
//  BRElementPackage
//
//  Created by Shine on 2020/1/21.
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit

class BRSwipeToPopInteractive : UIPercentDrivenInteractiveTransition{
    
    private var interactiveView : UIView?
    private var navigationController : UINavigationController?
    
    private let threshold :CGFloat  = 0.4
    
    convenience init(_ interactiveView : UIView? , _ navigationController : UINavigationController) {
        self.init()
        self.interactiveView = interactiveView
        self.navigationController = navigationController
        
        setupPanGesture()
        wantsInteractiveStart = false
    }
    
    private func setupPanGesture(){
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        panGesture.maximumNumberOfTouches = 1
        interactiveView?.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePanGesture(_ sender : UIPanGestureRecognizer){
        
        switch sender.state {
        case .began:
            sender.setTranslation(.zero, in: interactiveView)
            wantsInteractiveStart = true
            //add animate
            self.navigationController?.popViewController(animated: true)
        case .changed:
            let translation = sender.translation(in: interactiveView)

            guard translation.x >= 0 else {
                sender.setTranslation(.zero, in: interactiveView)
                return
            }
            
            let percentage = abs(translation.x / interactiveView!.bounds.size.height)
            
            update(percentage)
        case .ended:
            if percentComplete >= threshold {
                finish()
            }else{
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
