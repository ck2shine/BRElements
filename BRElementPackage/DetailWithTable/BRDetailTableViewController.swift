//
//  BRDetailTableViewController.swift
//  BRElementPackage
//
//  Created by i9400503 on 2020/1/6.
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit

class BRDetailTableViewController: UIViewController {



    //Device is iphone
    private var navBarHeightPlusStatusHeight: CGFloat {
        return UIDevice.isIphoneX() ? 88.0 : 64.0
    }

    @IBOutlet weak var upperView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)    }

    final private func setupUI(){
        if let childVC = self.children[0] as? BRDetailDataViewController{
            childVC.delegate = self
            childVC.upperViewHeight = upperView.bounds.height
        }
    }
}

extension BRDetailTableViewController : tableViewDelegate{
    func tableiViewDidScroll(translation: CGFloat) {
        upperView.frame = CGRect(x: 0, y: navBarHeightPlusStatusHeight - translation, width: upperView.bounds.width, height: upperView.bounds.height)
    }

}
