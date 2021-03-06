//
//  BRMainNavigationViewController.swift
//  BRElementPackage
//
//  Created by i9400503 on 2020/1/20.
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit

class BRMainNavigationViewController: UINavigationController {

    
    private var swipeBackInteractive:BRSwipeToPopInteractive!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
        self.swipeBackInteractive = BRSwipeToPopInteractive(self.view, self)
       
    }
    

}

extension BRMainNavigationViewController : UINavigationControllerDelegate {
     func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

           if operation == .pop {
               return BRSwipeFromLeftToRightTrasition()
           } else if operation == .push {
               return nil//UIViewControllerAnimatedTransitioning push時要套用的動畫
           }

           //回傳 nil 即走預設動畫
           return nil
       }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
       
        if animationController is BRSwipeFromLeftToRightTrasition{
            return self.swipeBackInteractive
        }
        return nil
    }
}
