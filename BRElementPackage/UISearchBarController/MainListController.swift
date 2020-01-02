//
//  MainListController.swift
//  BRElementPackage
//
//  Created by Shine on 2020/1/2.
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation
import UIKit
class MainListController :UIViewController{
    @IBOutlet weak var SearchFooterView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


extension MainListController : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }
    
    
}
