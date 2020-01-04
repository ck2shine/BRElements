//
//  DetailViewController.swift
//  BRElementPackage
//
//  Created by Shine on 2020/1/2.
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var deptData : Department?
    
    @IBOutlet weak var BranchLabel: UILabel!
    
    @IBOutlet weak var DeptLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        BranchLabel.text = deptData?.BranchName
        DeptLabel.text = deptData?.Dep?.rawValue
    }
   
}
