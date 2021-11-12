//
//  MoviePersistence.swift
//  MovieApp
//
//  Created by rasul on 11/6/21.
//

import Foundation
import CoreData
import CocoaLumberjackSwift

final class MoviePersistence: StorageProtocol {
  typealias T = ListModel
  
  private(set) var items: [T] = []
  
  private let backgroundContext: NSManagedObjectContext!
  private let context: NSManagedObjectContext!
  
  init(context: NSManagedObjectContext, backgroundContext: NSManagedObjectContext) {
    self.context = context
    self.backgroundContext = backgroundContext
  }
  
  func addList(_ item: T) {
    let list = fetchList(.uid(item.id))
    if list != nil {
      if !filter(id: item.id, entityID: Int(list!.id)) {
        let entity = ListEntity.find(byID: item.id, context: backgroundContext)
        item.createEntity(entity)
        backgroundContext.performAndWait {
          save(backgroundContext)
        }
      }
    } else {
      let entity = ListEntity.find(byID: item.id, context: backgroundContext)
      item.createEntity(entity)
      backgroundContext.performAndWait {
        save(backgroundContext)
      }
    }
  }
  
  func addMovie(_ item: MovieModel, listID: Int) {
    let movie = fetchMovie(.uid(item.id))
    if movie != nil {
      if !filter(id: item.id, entityID: Int(movie!.id)) {
        let listEntity = fetchList(.uid(listID))
        let entity = MovieEntity.find(byID: item.id, context: backgroundContext)
        item.createEntity(entity)
        listEntity?.addToMovies(entity)
        backgroundContext.performAndWait {
          save(backgroundContext)
        }
      }
    } else {
      let listEntity = fetchList(.uid(listID))
      let entity = MovieEntity.find(byID: item.id, context: backgroundContext)
      item.createEntity(entity)
      listEntity?.addToMovies(entity)
      backgroundContext.performAndWait {
        save(backgroundContext)
      }
    }
  }
  
  func remove(with id: Int) {
    let request: NSFetchRequest<ListEntity> = ListEntity.fetchRequest()
    let predicate = NSPredicate(format: "id = %d", id)
    request.predicate = predicate
    backgroundContext.performAndWait {
      do {
        guard let result = try backgroundContext.fetch(request).first else {
          DDLogError("an object with this identifier \(id) does not exist")
          return
        }
        backgroundContext.delete(result)
        try backgroundContext.save()
        DDLogInfo("list with id=\(id) removed from the database")
      } catch let error {
        DDLogError("error when deleting list with ID =\(id)\n\(error.localizedDescription)")
      }
    }
  }
  
  func removeMovie(with id: Int) {
    let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
    let predicate = NSPredicate(format: "id = %d", id)
    request.predicate = predicate
    backgroundContext.performAndWait {
      do {
        guard let result = try backgroundContext.fetch(request).first else {
          DDLogError("an object with this identifier \(id) does not exist")
          return
        }
        backgroundContext.delete(result)
        try backgroundContext.save()
        DDLogInfo("Movie with id=\(id) removed from the database")
      } catch let error {
        DDLogError("error when deleting movie with ID =\(id)\n\(error.localizedDescription)")
      }
    }
  }
  
  func fetchList(_ predicateType: PredicateType) -> ListEntity? {
    let request: NSFetchRequest<ListEntity> = ListEntity.fetchRequest()
    switch predicateType {
    case .uid(let id):
     let predicate = NSPredicate(format: "id = %d", id)
      request.predicate = predicate
      
      do {
        let result = try backgroundContext.fetch(request)
        guard let entity = result.first else {
          return nil
        }
        DDLogInfo("get List with ID = \(entity.id)")
        return entity
      } catch {
        DDLogError("an entity with this ID = \(id) does not exist")
        return nil
      }
    }
  }
  
//  func fetchMovieEntity(_ predicateType: PredicateType) -> MovieEntity? {
//    let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
//    switch predicateType {
//    case .uid(let id):
//     let predicate = NSPredicate(format: "id = %d", id)
//      request.predicate = predicate
//
//      do {
//        let result = try backgroundContext.fetch(request)
//        guard let entity = result.first else {
//          return nil
//        }
//        DDLogInfo("get movie with ID = \(entity.id)")
//        return entity
//      } catch {
//        DDLogInfo("an entity with this ID = \(id) does not exist")
//        return nil
//      }
//    }
//  }
  
  func filter(id: Int, entityID: Int) -> Bool {
    if entityID != id {
      return false
    } else {
      return true
    }
  }
  
  func fetch(_ predicate: NSPredicate?) {
    Thread.printCurrent()
    let request: NSFetchRequest<ListEntity> = ListEntity.fetchRequest()
    request.predicate = predicate
    let sortDescriptor = NSSortDescriptor(keyPath: \ListEntity.name, ascending: false)
    request.sortDescriptors = [sortDescriptor]
    
    do {
      let fetchResult = try backgroundContext.fetch(request)
      fetchResult.forEach {
        let item = ListModel.getEntities(entity: $0)
        items.append(item)
      }
      DDLogInfo("get all Lists")
      // completion(.success((self.items)))
    } catch {
      DDLogError("error while receiving lists \(error.localizedDescription)")
     // completion(.failure(.fetch(error)))
    }
  }
  
  func fetchItem(_ predicateType: PredicateType) -> ListModel? {
    let request: NSFetchRequest<ListEntity> = ListEntity.fetchRequest()
    switch predicateType {
    case .uid(let id):
     let predicate = NSPredicate(format: "id = %d", id)
      request.predicate = predicate
      
      do {
        let result = try context.fetch(request)
        guard let entity = result.first else {
          return nil
        }
        DDLogInfo("get list with id = \(entity.id)")
        return ListModel.getEntities(entity: entity)
      } catch {
        DDLogError("an entity with this id = \(id) does not exist")
        return nil
      }
    }
  }
  
  func fetchMovie(_ predicateType: PredicateType) -> MovieModel? {
    let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
    switch predicateType {
    case .uid(let id):
     let predicate = NSPredicate(format: "id = %d", id)
      request.predicate = predicate
      
      do {
        let result = try context.fetch(request)
        guard let entity = result.first else {
          return nil
        }
        DDLogInfo("get list with id = \(entity.id)")
        return MovieModel.getMovie(entity: entity)
      } catch {
        DDLogError("an entity with this id = \(id) does not exist")
        return nil
      }
    }
  }
  
  private func save(_ context: NSManagedObjectContext) {
    do {
      try context.save()
      DDLogInfo("created a new list")
    } catch let error {
      context.rollback()
      DDLogError("failed to save data \(error.localizedDescription)")
    }
  }
}

extension Thread {
  class func printCurrent() {
    print("\r⚡️: \(Thread.current)\r" + "🏭: \(OperationQueue.current?.underlyingQueue?.label ?? "None")\r")
  }
}
