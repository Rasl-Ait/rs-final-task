//
//  MovieDetailCoordinatorTest.swift
//  MovieAppTests
//
//  Created by rasul on 11/19/21.
//

import XCTest
@testable import MovieApp

class MovieDetailCoordinatorTest: XCTestCase {

  private var movieDetailCoordinator: MovieDetailCoordinatorProtocol!
  private var router: RouterMock!
  private var coordinatorFactory: CoordinatorFactoryMock!
  private var screenFactory: ScreenFactoryMock!
  private var tabBarController = TabBarController()
  
  override func setUp() {
    super.setUp()
    router = RouterMock()
    screenFactory = ScreenFactoryMock()
    coordinatorFactory = CoordinatorFactoryMock()
    movieDetailCoordinator = MovieDetailCoordinator(router: router,
                                                    coordinatorFactory: coordinatorFactory,
                                                    screenFactory: screenFactory,
                                                    movieID: 10)
  }
  
  func test_pushListVC() {
    screenFactory.makeListsScreenHandler = { _, _ in
      return ListsViewController()
    }
    
    self.coordinatorFactory.makeListsCoordinatorHandler = { router, vc in
      let coordinator = ListsCoordinator(router: router,
                                         coordinatorFactory: self.coordinatorFactory,
                                         screenFactory: self.screenFactory,
                                         tabBarViewController: vc)
      coordinator.screenType = .movieDetail
      return coordinator
    }
    
    movieDetailCoordinator.pushList(mediaID: 10)
    
   // XCTAssertEqual(router.pushModuleCallCount, 1)
    XCTAssertEqual(coordinatorFactory.makeListsCoordinatorCallCount, 1)
    XCTAssertEqual(screenFactory.makeListsScreenCallCount, 1)
  }
  
  func test_pop() {
    movieDetailCoordinator.pop()
    XCTAssertEqual(router.popModuleCallCount, 1)
  }
  
  func test_pushListDetailVC() {

    screenFactory.makeWebViewScreenHandler = { _, _ in
      return WebViewController()
    }

    movieDetailCoordinator.pushWebViewVC(stringURL: "http://any-url.com")

    XCTAssertEqual(router.pushCallCount, 1)
    XCTAssertEqual(screenFactory.makeWebViewScreenCallCount, 1)
  }
}

