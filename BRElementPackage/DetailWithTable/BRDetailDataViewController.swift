//
//  BRDetailDataViewController.swift
//  BRElementPackage
//
//  Created by i9400503 on 2020/1/6.
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit
protocol tableViewDelegate {
    func tableiViewDidScroll(translation : CGFloat)
}

class BRDetailDataCell : UITableViewCell{
    func setupCell(_ index : Int){
        textLabel?.text = String(index)
        detailTextLabel?.text = "Detail info words"
    }
}

class BRDetailDataViewController: UIViewController {
    @IBOutlet weak var dataTable: UITableView!
    
    var dataAry : [Int] = []
    var upperViewHeight : CGFloat?
    var delegate : tableViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        for idx in 1...20{
            dataAry.append(idx)
        }
        dataTable.contentInset = UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0)
    }

}

extension BRDetailDataViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataAry.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BRDetailDataCell", for: indexPath) as! BRDetailDataCell

        cell.setupCell(dataAry[indexPath.row])
        return cell
    }


}

extension BRDetailDataViewController : UITableViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //add label height back that is true origianl
        let translation = scrollView.contentOffset.y + (upperViewHeight ?? 0 )
        self.delegate?.tableiViewDidScroll(translation: translation)
    }
}
