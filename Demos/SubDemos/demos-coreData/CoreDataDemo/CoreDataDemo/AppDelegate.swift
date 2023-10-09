//
//  AppDelegate.swift
//  CoreDataDemo
//
//  Created by zhouweijie on 2019/4/25.
//  Copyright © 2019 zhouweijie. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let rootVC = window?.rootViewController as? ViewController {
            rootVC.container = persistentContainer
        }
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        persistentContainer.saveContext()
    }
    
    lazy var persistentContainer: DemoPersistentContainer = {
        let container = DemoPersistentContainer(name: "CoreDataDemo")
        container.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error {
                fatalError("Uable to load persistent stores: \(error)")
            }
        })
        return container
    }()


}

