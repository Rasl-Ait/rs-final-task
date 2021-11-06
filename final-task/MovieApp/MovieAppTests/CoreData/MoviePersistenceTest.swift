//
//  MoviePersistenceTest.swift
//  MovieAppTests
//
//  Created by rasul on 11/6/21.
//

import XCTest
import CoreData
@testable import MovieApp

class MoviePersistenceTest: XCTestCase {
  var coredataStack: CoreDataStack = CoreDataStack(modelName: "Model", storageType: .inMemory)
  var persistence: StorageProtocol!
  var list: ListModel!
  
  override func setUpWithError() throws {
    coredataStack = CoreDataStack(modelName: "Model", storageType: .inMemory)
    persistence = MoviePersistence(context: coredataStack.managedContext,
                                   backgroundContext: coredataStack.managedContext)
    list = ListModel(description: "text",
                     favoriteCount: 1,
                     id: 1, itemCount: 2,
                     listType: "movie",
                     name: "One",
                     posterPath: nil)
  }
  
  func test_addItem() throws {
    let request: NSFetchRequest<ListEntity> = ListEntity.fetchRequest()
    let context = coredataStack.managedContext
    
    persistence.add(list)
    let count = try context.count(for: request)
    XCTAssertEqual(count, 1)
  }
  
  func test_fetchItems() throws {
    let item = ListModel(description: "text",
                         favoriteCount: 1,
                         id: 2, itemCount: 2,
                         listType: "movie",
                         name: "One",
                         posterPath: nil)
    
    persistence.add(list)
    persistence.add(item)
    persistence.fetch(nil)
    
    XCTAssertEqual(persistence.items.count, 2)
  }

  func test_fetchPredicateItem() throws {
    persistence.add(list)
    let item = self.persistence.fetchItem(.uid(list.id))
    XCTAssertNotNil(item)
  }

  func test_fetchPredicateItemNil() throws {

    persistence.add(list)
    let item = self.persistence.fetchItem(.uid(2))
    XCTAssertNil(item)
  }

  func test_removeItemNil() throws {
    
    let item = ListModel(description: "text",
                         favoriteCount: 1,
                         id: 2, itemCount: 2,
                         listType: "movie",
                         name: "One",
                         posterPath: nil)
    
    let item2 = ListModel(description: "text",
                          favoriteCount: 1,
                          id: 3, itemCount: 2,
                          listType: "movie",
                          name: "One",
                          posterPath: nil)
    persistence.add(list)
    persistence.add(item)
    persistence.add(item2)

    persistence.remove(with: item.id)
    let model = persistence.fetchItem(.uid(item.id))

    XCTAssertNil(model)
  }
}
