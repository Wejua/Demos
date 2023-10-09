//
//  UIImage+Utilities.swift
//  YYVideo
//
//  Created by zhouweijie on 2019/9/27.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func fromColor(color: UIColor, size: CGSize) -> UIImage? {
        if (size.width <= 0 || size.height <= 0) {return nil}
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(rect)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext();
            return image;
        }
        return nil
    }
    
    /// 根据颜色生成一张图片
    class func fromColor(color: UIColor) -> UIImage? {
        return self.fromColor(color: color, size: CGSize(width: 1, height: 1))
    }

}
