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

    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        translatesAutoresizingMaskIntoConstraints = false
//                       contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//                       contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
//                       contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//                       contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var dataAry: [String] = []

}

extension BRDynamicTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return dataAry.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BRDynamicExpandCell", for: indexPath) as! BRDynamicExpandCell
        cell.showTextLabel.text = dataAry[indexPath.row]
        
        return cell
    }

}
