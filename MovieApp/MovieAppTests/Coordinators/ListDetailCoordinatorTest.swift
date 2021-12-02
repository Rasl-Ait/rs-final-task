//
//  ListDetailCoordinatorTest.swift
//  MovieAppTests
//
//  Created by rasul on 11/19/21.
//

import XCTest
@testable import MovieApp

class ListDetailCoordinatorTest: XCTestCase {
  
  private var listsDetailCoordinator: ListDetailCoordinatorProtocol!
  private var router: RouterMock!
  private var coordinatorFactory: CoordinatorFactoryMock!
  private var screenFactory: ScreenFactoryMock!
  private var tabBarController = TabBarController()
  private var list: ListModel!
  
  override func setUp() {
    super.setUp()
    router = RouterMock()
    screenFactory = ScreenFactoryMock()
    coordinatorFactory = CoordinatorFactoryMock()
    
    let results = SharedTestHelpers.getResponce(file: "ListModel", type: ListResponce.self)
    
    list = results.item?.results.first
    
    listsDetailCoordinator = ListDetailCoordinator(router: router,
                                                   coordinatorFactory: coordinatorFactory,
                                                   screenFactory: screenFactory,
                                                   list: list)
  }
  
  func test_pushMovieDetailVC() {
    
    screenFactory.makeMovieDetailScreenHandler = { _, _ in
      return MovieDetailViewController()
    }
    
    coordinatorFactory.makeMovieDetailCoordinatorHandler = { router, id in
      return MovieDetailCoordinator(router: router, coordinatorFactory: self.coordinatorFactory, screenFactory: self.screenFactory, movieID: id)
    }
    
    listsDetailCoordinator.pushMovieDetailVC(id: list.id)
    
    XCTAssertEqual(router.pushModuleCallCount, 1)
    XCTAssertEqual(coordinatorFactory.makeMovieDetailCoordinatorCallCount, 1)
    XCTAssertEqual(screenFactory.makeMovieDetailScreenCallCount, 1)
  }
  
  func test_pop() {
    listsDetailCoordinator.pop()
    XCTAssertEqual(router.popModuleCallCount, 1)
  }
}
