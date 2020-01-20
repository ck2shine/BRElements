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
    
    
    convenience init(_ presenter : UIViewController , _ interactiveView : UIView) {
        self.init()
        self.interactiveView = interactiveView
        self.presenter = presenter
        setupGesture()
    }
    
    private func setupGesture(){
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlerPanEvent(_:)))
        panGesture.maximumNumberOfTouches = 1
        panGesture.delegate = self
        interactiveView?.addGestureRecognizer(panGesture)
        
        wantsInteractiveStart = false
    }
    
    
    @objc func handlerPanEvent(_ sender : UIPanGestureRecognizer){
        
    }
}

extension BRPullToDimissTransition : UIGestureRecognizerDelegate{
    
}
