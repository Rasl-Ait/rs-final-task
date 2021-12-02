//
//  CoreDataStack.swift
//  MovieApp
//
//  Created by rasul on 11/6/21.
//

import Foundation
import CoreData

enum StorageType {
    case persistent, inMemory
}

final class CoreDataStack {
  
  private let modelName: String
  private let storageType: StorageType
  
  init(modelName: String, storageType: StorageType = .persistent) {
    self.modelName = modelName
    self.storageType = storageType
  }
  
  lazy var managedContext: NSManagedObjectContext = {
    return self.storeContainer.viewContext
  }()
  
  lazy var backgroundContext: NSManagedObjectContext = {
    return self.storeContainer.newBackgroundContext()
  }()
  
  private lazy var storeContainer: NSPersistentContainer = {

    let container = NSPersistentContainer(name: self.modelName)
    container.viewContext.automaticallyMergesChangesFromParent = true
    if storageType == .inMemory {
      container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
    }

    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()
  
  private func setupIfMemoryStorage(_ storageType: StorageType) {
      if storageType  == .inMemory {
          let description = NSPersistentStoreDescription()
          description.url = URL(fileURLWithPath: "/dev/null")
          self.storeContainer.persistentStoreDescriptions = [description]
      }
  }
  
  func saveContext () {
    guard managedContext.hasChanges else { return }
    
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Unresolved error \(error), \(error.userInfo)")
    }
  }
}
