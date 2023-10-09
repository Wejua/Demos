//
//  UIViewController+Extension.swift
//  YYVideo
//
//  Created by kk_work on 2019/9/16.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import Foundation


extension UIViewController {
    
    // 获取项目的顶层显示控制器
    static func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController
        {
            return getTopViewController(base: nav.visibleViewController)
            
        }
        if let tab = base as? UITabBarController {
            return getTopViewController(base: tab.selectedViewController)
            
        }
        if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
    
}
