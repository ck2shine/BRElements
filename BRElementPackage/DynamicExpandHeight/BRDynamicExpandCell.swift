//
//  BRDynamicExpandCell.swift
//  BRElementPackage
//
//  Created by i9400503 on 2020/1/17.
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit

class BRDynamicExpandCell: UICollectionViewCell {
    
    @IBOutlet weak var showTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 3.0
        layer.borderWidth = 1.0
        layer.borderColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1).cgColor
               
    }
    
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
      
        setNeedsLayout()
        layoutIfNeeded()

        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)

        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        

        return layoutAttributes
    }
}
