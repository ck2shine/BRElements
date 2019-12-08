//
//  ViewController.swift
//  BRElementPackage
//
//  Created by Shine on 2019/12/8.
//  Copyright © 2019 Shine. All rights reserved.
//

import UIKit

class BRSelectViewController: UIViewController {
    
    
    
    lazy var functionAry : [BRFunctiomModel] = {
        
        
        
        
        let imageFunction = BRFunctiomModel("Imagefunction", functionAry: [.BRZoomImage])
                
        return [imageFunction]
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

extension BRSelectViewController : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return functionAry.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return functionAry[section].functionAry?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell
        
        if let dequeueCell = tableView.dequeueReusableCell(withIdentifier: "FunctionCell") as? UITableViewCell{
            cell = dequeueCell
        }else{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "FunctionCell")
        }
        if let model = functionAry[indexPath.section].functionAry?[indexPath.row]{
            
        }
        
        return cell
    }
    
    
}

