//
//  BRDynamicCollectionView.swift
//  BRElementPackage
//
//  Created by i9400503 on 2020/1/17.
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit

class BRDynamicCollectionView: UICollectionView {

    override func layoutSubviews() {
        super.layoutSubviews()
       
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
             self.invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {       
        return contentSize
    }
}
