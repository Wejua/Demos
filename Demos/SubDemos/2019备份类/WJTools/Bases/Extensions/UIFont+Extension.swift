//
//  UIFont+YY.swift
//  YPVideo
//
//  Created by zhouweijie on 2019/9/29.
//  Copyright © 2019 zhouweijie. All rights reserved.
//

import UIKit

extension UIFont {
    
    convenience init(pingFangSCMediumSize: CGFloat) {
        self.init(name: "PingFangSC-Medium", size: pingFangSCMediumSize)!
    }
    
    convenience init(pingFangSCRegularSize: CGFloat) {
        self.init(name: "PingFangSC-Regular", size: pingFangSCRegularSize)!
    }
    
    convenience init(pingFangSCSemiboldSize: CGFloat) {
        self.init(name: "PingFangSC-Semibold", size: pingFangSCSemiboldSize)!
    }
    
    convenience init(pingFangHKRegularSize: CGFloat) {
        self.init(name: "PingFangHK-Regular", size: pingFangHKRegularSize)!
    }
    
//    convenience init(barlowCondensedMediumSize: CGFloat) {
//        self.init(name: "BarlowCondensed-Medium", size: barlowCondensedMediumSize)!
//    }
    
}
