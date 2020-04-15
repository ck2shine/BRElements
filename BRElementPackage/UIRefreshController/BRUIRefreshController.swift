//
//  BRUIRefreshController.swift
//  BRElementPackage
//
//  Created by Shine on 2020/4/15.
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit

class BRUIRefreshController: UIViewController {

    @IBOutlet weak var dataTable: UITableView!
    
    var dataAry : [Int] = []
    
    var refreshControl : UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for idx in 0...Int.random(in: 0..<20){
            dataAry.append(idx)
        }
        
        dataTable.delegate = self
        dataTable.dataSource = self
        
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = .systemRed
        refreshControl?.attributedTitle = NSAttributedString(string: "ReloadingData...")
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        dataTable.addSubview(refreshControl!)
        
    }
    
    @IBAction func RefreshBarItemAction(_ sender: Any) {
        refreshControl?.beginRefreshing()
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            //trigger 
            self.dataTable.contentOffset = CGPoint(x: 0, y: -self.refreshControl!.bounds.height)
            
        }) { _ in
            self.loadData()
        }
        
    }
    
}

extension BRUIRefreshController : UITableViewDataSource , UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataAry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell?
        
        if let deQueueCell = tableView.dequeueReusableCell(withIdentifier: "cell"){
            cell = deQueueCell
        }else{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        
        cell?.textLabel?.text = "This is row : \(indexPath.item)"
        
        return cell!
    }
   
    
}

extension BRUIRefreshController {
    
    
    @objc final private func loadData(){
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            
            self.refreshControl?.endRefreshing()
            
            for _ in 1...5{
                self.dataAry.append(self.dataAry.count)
                self.dataTable.insertRows(at: [[0,self.dataAry.count-1]], with: .fade)
            }
            
            self.dataTable.scrollToRow(at: [0,self.dataAry.count-1], at: .bottom, animated: true)
            
        }
        
    }
}
