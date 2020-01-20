//
//  BRMainNavigationViewController.swift
//  BRElementPackage
//
//  Created by i9400503 on 2020/1/20.
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit

class BRMainNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }
    

}

extension BRMainNavigationViewController : UINavigationControllerDelegate {
     func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

           if operation == .pop {
               return nil //UIViewControllerAnimatedTransitioning 返回時要套用的動畫
           } else if operation == .push {
               return nil//UIViewControllerAnimatedTransitioning push時要套用的動畫
           }

           //回傳 nil 即走預設動畫
           return nil
       }
}
