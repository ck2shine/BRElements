//
//  BRUIViewControllerTrasitionVC.swift
//  BRElementPackage
//
//  Created by i9400503 on 2020/1/20.
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit

class BRUIViewControllerTrasitionVC: UIViewController {

    @IBAction func PresentNormalAction(_ sender: Any) {
        performSegue(withIdentifier: "toPresent", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case .some("toPresent"):
            if let toVC = segue.destination as? BRPresentedVC{
                //original present style , in ios13 , default is UIModalPresentationAutomatic
                toVC.modalPresentationStyle = .automatic
                //toVC.modalPresentationStyle = .fullScreen
            }
        default:
            break
        }
    }
    

}
