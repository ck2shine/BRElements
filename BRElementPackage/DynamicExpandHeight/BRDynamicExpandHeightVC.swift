//
//  BRDynamicExpandHeight.swift
//  BRElementPackage
//
//  Created by i9400503 on 2020/1/17.
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit

class BRDynamicExpandHeightVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func reloadItem(_ sender: Any) {
        
        tableView.reloadData()
    }
    var wordAry: [String] = []
    
    var words = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeData()
        
    }
    
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.reloadData()
    }
    
    
}


extension BRDynamicExpandHeightVC: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 || indexPath.row == 20 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BRDynamicTableViewCell", for: indexPath) as! BRDynamicTableViewCell
            if let layout = cell.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                
//                layout.itemSize = CGSize(width: tableView.bounds.width - 20, height: 50)
//                layout.estimatedItemSize = .zero
                
                layout.estimatedItemSize =  CGSize(width: tableView.bounds.width - 20, height: 50)
            }
            
            cell.dataAry = wordAry
            
            cell.collectionView.reloadData()
            cell.collectionView.collectionViewLayout.invalidateLayout()
            cell.collectionView.layoutIfNeeded()            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BRNormalTableViewCell", for: indexPath)
            cell.textLabel?.text = "Test123"
            cell.detailTextLabel?.text = "Normal3456"
            return cell
        }
        
        
    }
}

extension BRDynamicExpandHeightVC {
    final private func initializeData() {
        
        wordAry =  (0..<8).map { (_) -> String in
            var letters = ""
            
            for _ in 0...(Int.random(in: 50...80)) {
                let letter =  words[Int.random(in: 0..<words.count)]
                letters.append(letter)
            }
            
            return letters
        }
        
    }
}
