//
//  BRUIViewControllerTrasitionVC.swift
//  BRElementPackage
//
//  Created by i9400503 on 2020/1/20.
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit

class BRUIViewControllerTrasitionVC: UIViewController {
    @IBAction func PresentCustomerAction(_ sender: Any) {
        let toVC = UIStoryboard(name: "BRUIViewControllerTrasition", bundle: nil).instantiateViewController(identifier: "BRCustomPresentVC") as! BRCustomPresentVC
        toVC.transitioningDelegate = toVC
        toVC.modalPresentationStyle = .custom
        self.present(toVC, animated: true, completion: nil)
    }
    
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
            if let toVC = segue.destination as? BRNormalPresentedVC{
                //original present style , in ios13 , default is UIModalPresentationAutomatic
                toVC.modalPresentationStyle = .automatic
                //toVC.modalPresentationStyle = .fullScreen
            }
        case .some("toCustom"):
            if let toVC = segue.destination as? BRCustomPresentVC{

                toVC.transitioningDelegate = toVC
                toVC.modalPresentationStyle = .custom
                //toVC.modalPresentationStyle = .fullScreen
            }
        default:
            break
        }
    }
    

}
