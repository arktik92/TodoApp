
//
//  CoreDataManager.swift
//  ToDoApp
//
//  Created by Esteban SEMELLIER on 05/01/2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "ToDo")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    
    func updateItem() {
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
        }
        
    }
    
    func deleteItem(item: Item) {
        
        persistentContainer.viewContext.delete(item)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
        
    }
    
    func getAllItems() -> [Item] {
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
        
    }
    
    func getDonedItems() -> [Item] {
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
    
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
        
    }
    
    func saveItem(title: String, content: String, done: Bool, lastTime: Date, simpleRightDirection: Float, timestamp: Date, category: String ) {
        
        let item = Item(context: persistentContainer.viewContext)
        item.title = title
        item.content = content
        item.done = done
        item.lastTime = lastTime
        item.simpleRightDirectionSliderOffsetX = simpleRightDirection
        item.timestamp = timestamp
        item.category = category
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save item \(error)")
        }
        
    }
    
}

