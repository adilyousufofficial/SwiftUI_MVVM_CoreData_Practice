//
//  CoreDataManager.swift
//  PaybackCodeChallange
//
//  Created by **** on 27/08/2022.
//

import Foundation
import CoreData

enum TaskError: Error {
    case taskNotFound
}

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    static let shared: CoreDataManager = CoreDataManager()
    
    private init() {
        
        persistentContainer = NSPersistentContainer(name: "TilesListModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func getTaskById(id: NSManagedObjectID) -> ShoppingList? {
        
        do {
            return try viewContext.existingObject(with: id) as? ShoppingList
        } catch {
            return nil
        }
        
    }
    
    func deleteTask(task: ShoppingList) {
        
        viewContext.delete(task)
        save()
        
    }
    
    func getAllTasks() -> [ShoppingList] {
        
        let request: NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        
        do {
            let result = try viewContext.fetch(request)
            if !result.isEmpty {
                return result
            } else {
                return []
            }
        } catch {
            return []
        }
        
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
}
