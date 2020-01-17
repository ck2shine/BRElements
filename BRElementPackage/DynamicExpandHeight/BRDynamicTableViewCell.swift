//
//  BRDynamicTableViewCell.swift
//  BRElementPackage
//
//  Created by i9400503 on 2020/1/17.
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit

class BRDynamicTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: BRDynamicCollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var dataAry : [String] = []

}

extension BRDynamicTableViewCell : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return dataAry.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BRDynamicExpandCell", for: indexPath) as! BRDynamicExpandCell
        cell.showTextLabel.text = dataAry[indexPath.row]
//        cell.LabelWidth.constant = UIScreen.main.bounds.width
//        cell.LabelWidth.isActive = true
        return cell
    }


}

