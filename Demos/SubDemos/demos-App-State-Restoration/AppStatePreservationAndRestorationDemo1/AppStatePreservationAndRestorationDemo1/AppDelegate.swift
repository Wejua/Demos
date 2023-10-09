//
//  AppDelegate.swift
//  AppStatePreservationAndRestorationDemo1
//
//  Created by zhouweijie on 2019/4/19.
//  Copyright © 2019 zhouweijie. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return true
    }

}

