//
//  UIView+Extension.swift
//  YYVideo
//
//  Created by zhouweijie on 10/31/19.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit

extension UIView {
    func viewController() -> UIViewController? {
        var view: UIResponder = self
        while view.next != nil {
            if view.next!.isKind(of: UIViewController.self) {
                return view.next as? UIViewController
            } else {
                view = view.next!
            }
        }
        return nil
    }
    
    func subViewWithClassName(className: String) -> UIView? {
        for view in self.subviews {
            if NSStringFromClass(type(of: view)) == className {
                return view
            }
            let result = view.subViewWithClassName(className: className)
            if result != nil {
                return result
            }
        }
        return nil
    }
}

