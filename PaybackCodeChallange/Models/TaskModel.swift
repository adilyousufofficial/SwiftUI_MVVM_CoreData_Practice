//
//  TaskModel.swift
//  PaybackCodeChallange
//
//  Created by **** on 26/08/2022.
//

import CoreData

struct TaskModel {
    
    let task: ShoppingList
    
    var id: NSManagedObjectID? {
        return task.objectID
    }
    
    var title: String {
        return task.title ?? ""
    }
    
    var isCompleted: Bool {
        return task.isCompleted
    }
    
    var dateCreated: Date {
        return task.dateCreated ?? Date()
    }
}
