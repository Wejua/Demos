//
//  UITabbar+Extension.swift
//  QiKeWang
//
//  Created by 胡浩 on 2017/11/26.
//  Copyright © 2017年 QiKeWang. All rights reserved.
//

import Foundation

extension UITabBar {
    /// 显示红点
    func showBadgeOnItem(index: Int) {
        removeBadgeOnItem(index: index)
        let imageView = UIImageView(image: UIImage(named: "提示点点"))
        imageView.tag = index
        let percentX = (CGFloat(index) + 1.0) / 4.0
        let x = ceil(percentX * bounds.size.width)
        let y = ceil(0.1 * bounds.size.height)
        imageView.origin = CGPoint(x: x, y: y)
        addSubview(imageView)
        bringSubviewToFront(imageView)
    }
    
    /// 隐藏红点
    func hideBadgeOnItem(index: Int) {
        removeBadgeOnItem(index: index)
    }
    
    /// 移除红点
    func removeBadgeOnItem(index: Int) {
        for subView in subviews {
            if subView.tag == index {
                subView.removeFromSuperview()
            }
        }
    }
    
}
