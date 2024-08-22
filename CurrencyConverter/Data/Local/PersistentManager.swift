//
//  PersistentManager.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation
import CoreData

class PersistentManager {
    
    static let shared = PersistentManager()
    
    private let container: NSPersistentContainer
    
    let context: NSManagedObjectContext
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CurrencyConverter")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        context = container.viewContext
        context.automaticallyMergesChangesFromParent = true
    }
    
    // MARK: - Core Data Saving support

    func saveContext () throws {
        do {
            if context.hasChanges {
                try context.save()
            }
        }
        catch {
            context.rollback()
            throw error
        }
    }
}
