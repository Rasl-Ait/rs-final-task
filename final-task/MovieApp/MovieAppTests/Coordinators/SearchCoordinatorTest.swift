//
//  SearchCoordinatorTest.swift
//  MovieAppTests
//
//  Created by rasul on 11/19/21.
//

import XCTest
@testable import MovieApp

class SearchCoordinatorTest: XCTestCase {

  private var searchCoordinator: SearchCoordinatorProtocol!
  private var router: RouterMock!
  private var coordinatorFactory: CoordinatorFactoryMock!
  private var screenFactory: ScreenFactoryMock!
  private var tabBarController = TabBarController()
  
  override func setUp() {
    super.setUp()
    router = RouterMock()
    screenFactory = ScreenFactoryMock()
    coordinatorFactory = CoordinatorFactoryMock()
    searchCoordinator = SearchCoordinator(router: router, coordinatorFactory: coordinatorFactory, screenFactory: screenFactory, tabBarViewController: TabBarController())
  }
  
  func test_pushMovieDetailVC() {
    screenFactory.makeMovieDetailScreenHandler = { _, _ in
      return MovieDetailViewController()
    }
  
    coordinatorFactory.makeMovieDetailCoordinatorHandler = { router, id in
      return MovieDetailCoordinator(router: router, coordinatorFactory: self.coordinatorFactory, screenFactory: self.screenFactory, movieID: id)
    }
    
    searchCoordinator.pushMovieDetailVC(id: 10)
    
    XCTAssertEqual(router.pushCallCount, 1)
    XCTAssertEqual(coordinatorFactory.makeMovieDetailCoordinatorCallCount, 1)
    XCTAssertEqual(screenFactory.makeMovieDetailScreenCallCount, 1)
  }
  
  func test_pop() {
    searchCoordinator.pop()
    XCTAssertEqual(router.popModuleCallCount, 1)
  }
}
