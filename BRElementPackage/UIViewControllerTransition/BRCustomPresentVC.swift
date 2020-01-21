//
//  BRCustomPresentVC.swift
//  BRElementPackage
//
//  Created by i9400503 on 2020/1/21.
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit

class BRCustomPresentVC: UIViewController {

    private var dragDownToDismiss: BRPullToDimissTransition!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.dragDownToDismiss = BRPullToDimissTransition(self,view)
    }

}


extension BRCustomPresentVC :  UIViewControllerTransitioningDelegate{
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return dragDownToDismiss
    }


    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            return PresendAndDismissTransition(isDismiss: false)
       }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresendAndDismissTransition(isDismiss: true)
    }



    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
}
