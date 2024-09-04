//
//  AppDelegate.swift
//  PWD Drishti
//
//  Created by Aditya Sharma on 08/08/24.
//

import UIKit
import CoreData


class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Location") // Replace with your model name
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // Core Data saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
