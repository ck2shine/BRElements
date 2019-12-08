//
//  BRFunctiomModel.swift
//  BRElementPackage
//
//  Created by Shine on 2019/12/8.
//  Copyright © 2019 Shine. All rights reserved.
//

import Foundation




struct BRFunctiomModel {
    

    enum BRFunction {
        case BRZoomImage
    }
    
    var functionTitle: String?
    
    var functionAry : [BRFunction]?
        
    init(_ title : String? ,  functionAry : [BRFunction]) {
        self.functionAry = functionAry
        self.functionTitle = title
    }
    
}
