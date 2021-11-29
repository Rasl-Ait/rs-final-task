//
//  AuthCoordinatorTest.swift
//  MovieAppTests
//
//  Created by rasul on 11/19/21.
//

import XCTest
@testable import MovieApp

class AuthCoordinatorTest: XCTestCase {

  private var authCoordinator: AuthCoordinatorProtocol!
  private var router: RouterMock!
  private var coordinatorFactory: CoordinatorFactoryMock!
  private var screenFactory: ScreenFactoryMock!
  private var tabBarController = TabBarController()
  
  override func setUp() {
    super.setUp()
    router = RouterMock()
    screenFactory = ScreenFactoryMock()
    coordinatorFactory = CoordinatorFactoryMock()
    authCoordinator = AuthCoordinator(router: router, coordinatorFactory: coordinatorFactory, screenFactory: screenFactory)
  }
  
//  func test_pushTabBar() {
//
//    screenFactory.makeListsScreenHandler = { _, _ in
//      return ListsViewController()
//    }
//
//    self.coordinatorFactory.makeListsCoordinatorHandler = { nav in
//      return ListsCoordinator(router: self.router,
//                              coordinatorFactory: self.coordinatorFactory,
//                              screenFactory: self.screenFactory)
//    }
//
//    coordinatorFactory.makeTabBarCoordinatorHandler = {
//      let module = TabBarController()
//      let coordinator = TabBarCoordinator(tabBarView: module, coordinatorFactory: self.coordinatorFactory)
//      return (coordinator, module)
//    }
//
//    screenFactory.makeSearchScreenHandler = { _ in
//      return SearchViewController()
//    }
//
//    coordinatorFactory.makeSearchCoordinatorHandler = { nav in
//      return SearchCoordinator(router: self.router,
//                               coordinatorFactory: self.coordinatorFactory,
//                               screenFactory: self.screenFactory)
//    }
//
//    screenFactory.makeFavoriteScreenHandler = { _ in
//      return FavoriteViewController()
//    }
//
//    coordinatorFactory.makeFavoriteCoordinatorHandler = { nav in
//      return FavoriteCoordinator(router: self.router,
//                                 coordinatorFactory: self.coordinatorFactory,
//                                 screenFactory: self.screenFactory)
//    }
//
//    authCoordinator.finishFlow = {
//
//    }
//
//    authCoordinator.pushTabBar()
//
//    XCTAssertEqual(router.setRootModuleHideBarCallCount, 1)
//    XCTAssertEqual(coordinatorFactory.makeTabBarCoordinatorCallCount, 1)
//    XCTAssertEqual(coordinatorFactory.makeListsCoordinatorCallCount, 1)
//    XCTAssertEqual(coordinatorFactory.makeSearchCoordinatorCallCount, 1)
//    XCTAssertEqual(coordinatorFactory.makeFavoriteCoordinatorCallCount, 1)
//    XCTAssertEqual(screenFactory.makeListsScreenCallCount, 1)
//    XCTAssertEqual(screenFactory.makeSearchScreenCallCount, 1)
//    XCTAssertEqual(screenFactory.makeFavoriteScreenCallCount, 1)
//  }
}
