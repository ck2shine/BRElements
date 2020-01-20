//
//  BRPresentedVC.swift
//  BRElementPackage
//
//  Created by i9400503 on 2020/1/20.
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit

class BRPresentedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.presentationController?.delegate = self

        //cancel drag down close menu
        self.isModalInPresentation = false
    }

}

extension BRPresentedVC : UIAdaptivePresentationControllerDelegate{


    //cancenl dismiss when drag down
    func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        return false
    }

    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        let alert = UIAlertController(title: "close", message: "are you sure close window?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "confirm", style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
            }))
        alert.addAction(UIAlertAction(title: "continue", style: .cancel, handler: nil))
        self.present(alert, animated: true)

    }
}
