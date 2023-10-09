//
//  UIWindow+FLEX.swift
//  QiKeWang
//
//  Created by 胡浩 on 2017/8/8.
//  Copyright © 2017年 QiKeWang. All rights reserved.
//

import UIKit

#if DEBUG

    import FLEX
    /*
     在 DEBUG 情况下,晃动手机会出现调试界面，模拟器cmd+F
     */
    extension UIWindow {
        open override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
            super.motionBegan(motion, with: event)
            if motion == .motionShake{
                FLEXManager.shared().isNetworkDebuggingEnabled = true
                FLEXManager.shared().showExplorer()
            }
        }
    }

#endif

