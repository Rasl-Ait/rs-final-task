//
//  FavoriteCoordinatorTest.swift
//  MovieAppTests
//
//  Created by rasul on 11/19/21.
//

import XCTest
@testable import MovieApp

class FavoriteCoordinatorTest: XCTestCase {

  private var favoriteCoordinator: FavoriteCoordinatorProtocol!
  private var router: RouterMock!
  private var coordinatorFactory: CoordinatorFactoryMock!
  private var screenFactory: ScreenFactoryMock!
  private var tabBarController = TabBarController()
  
  override func setUp() {
    super.setUp()
    router = RouterMock()
    screenFactory = ScreenFactoryMock()
    coordinatorFactory = CoordinatorFactoryMock()
    favoriteCoordinator = FavoriteCoordinator(router: router, coordinatorFactory: coordinatorFactory, screenFactory: screenFactory)
  }
  
  func test_pushMovieDetailVC() {
    
    screenFactory.makeMovieDetailScreenHandler = { _, _ in
      return MovieDetailViewController()
    }
  
    coordinatorFactory.makeMovieDetailCoordinatorHandler = { router, id in
      return MovieDetailCoordinator(router: router, coordinatorFactory: self.coordinatorFactory, screenFactory: self.screenFactory, movieID: id)
    }
    
    favoriteCoordinator.pushMovieDetailVC(id: 10)
    
    XCTAssertEqual(router.pushModuleCallCount, 1)
    XCTAssertEqual(coordinatorFactory.makeMovieDetailCoordinatorCallCount, 1)
    XCTAssertEqual(screenFactory.makeMovieDetailScreenCallCount, 1)
  }
}
