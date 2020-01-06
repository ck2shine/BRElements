//
//  UIDevice+Extension.swift
//  BRElementPackage
//
//  Created by i9400503 on 2020/1/6.
//  Copyright © 2020 Shine. All rights reserved.
//

import UIKit
extension UIDevice{
    public class func isIphoneX()->Bool{
        if UIDevice().userInterfaceIdiom == .phone {
        switch UIScreen.main.nativeBounds.height {
            case 1136,1334,1920, 2208:
                return false
            case 2436,2688,1792:
                return true
            default:
               return false
            }
        }
        return false
    }
}


