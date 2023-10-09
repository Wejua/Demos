//
//  DemoPersistentContainer.swift
//  CoreDataDemo
//
//  Created by zhouweijie on 2019/4/25.
//  Copyright © 2019 zhouweijie. All rights reserved.
//

import UIKit
import CoreData

class DemoPersistentContainer: NSPersistentContainer {
    func saveContext(backgroundContext: NSManagedObjectContext? = nil) {
        let context = backgroundContext ?? viewContext
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
}
