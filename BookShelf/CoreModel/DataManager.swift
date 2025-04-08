//
//  DataManager.swift
//  BookShelf
//
//  Created by Елизавета Кравченкова on 08.04.2025.
//

import Foundation
import CoreData

class DataManager {
    
    static let shared = DataManager()
    
    private init() {}
    
    var viewContext : NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BookCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Не удалось загрузить хранилище: \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () -> Result<Void, Error> {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                return .failure(error)
            }
        }
        return .success(())
    }
}
