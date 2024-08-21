//
//  PersistentManager.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation
import CoreData

class PersistentManager {
    
    // MARK: - Singleton
    
    private init() { }
    
    static let shared = PersistentManager()
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CurrencyConverter")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    var taskContext: NSManagedObjectContext {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }
    
    func saveTaskContext(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
                context.reset()
            }
            catch {
                print(error)
            }
        }
    }

    // MARK: - Core Data Saving support

    func saveContext () throws {
        if context.hasChanges {
            try context.save()
        }
    }
}
