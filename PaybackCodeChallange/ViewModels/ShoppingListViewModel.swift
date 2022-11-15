//
//  ShoppingListViewModel.swift
//  PaybackCodeChallange
//
//  Created by **** on 26/08/2022.
//

import SwiftUI
import CoreData

class ShoppingListViewModel: ObservableObject {
    
    var title: String = ""
    @Published var tasks: [TaskModel] = []
    
    init() {
        getAllTasks()
    }
    
    func getAllTasks() {
        tasks = CoreDataManager.shared.getAllTasks().map(TaskModel.init)
        tasks.sort(by: {$0.dateCreated > $1.dateCreated })
    }
    
    func update(_ vs: TaskModel) throws {
        
        guard let taskId = vs.id else {
            throw TaskError.taskNotFound
        }
        
        guard let task = CoreDataManager.shared.getTaskById(id: taskId) else {
            throw TaskError.taskNotFound
        }
        
        task.isCompleted = !vs.isCompleted
        
        do {
            try CoreDataManager.shared.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func delete(_ task: TaskModel) {
        
        let existingTask = CoreDataManager.shared.getTaskById(id: task.id!)
        if let existingTask = existingTask {
            CoreDataManager.shared.deleteTask(task: existingTask)
        }
    }
    
    func save() {
        
        let task = ShoppingList(context: CoreDataManager.shared.viewContext)
        task.title = title
        task.dateCreated = Date()
        task.isCompleted = false
        
        CoreDataManager.shared.save()
    }
}
