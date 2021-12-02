//
//  ListCoordinatorTest.swift
//  MovieAppTests
//
//  Created by rasul on 11/19/21.
//

import XCTest
@testable import MovieApp

class ListCoordinatorTest: XCTestCase {

  private var listsCoordinator: ListsCoordinatorProtocol!
  private var router: RouterMock!
  private var coordinatorFactory: CoordinatorFactoryMock!
  private var screenFactory: ScreenFactoryMock!
  private var tabBarController = TabBarController()
  
  override func setUp() {
    super.setUp()
    router = RouterMock()
    screenFactory = ScreenFactoryMock()
    coordinatorFactory = CoordinatorFactoryMock()
    listsCoordinator = ListsCoordinator(router: router,
                                        coordinatorFactory: coordinatorFactory,
                                        screenFactory: screenFactory)
  }
  
  func test_pushDetailVC() {
    let results = SharedTestHelpers.getResponce(file: "ListModel", type: ListResponce.self)
    
    guard let list = results.item?.results.first else { return }
    
    screenFactory.makeListDetailScreenHandler = { _, _ in
      return ListDetailViewController()
    }
    
    self.coordinatorFactory.makeListDetailCoordinatorHandler = { router, list in
      return ListDetailCoordinator(router: router,
                                   coordinatorFactory: self.coordinatorFactory,
                                   screenFactory: self.screenFactory,
                                   list: list)
    }
    
    listsCoordinator.pushListDetailVC(list: list)
    
    XCTAssertEqual(router.pushModuleCallCount, 1)
    XCTAssertEqual(coordinatorFactory.makeListDetailCoordinatorCallCount, 1)
    XCTAssertEqual(screenFactory.makeListDetailScreenCallCount, 1)
  }
  
  func test_pop() {
    listsCoordinator.pop()
    XCTAssertEqual(router.popModuleCallCount, 1)
  }
}
