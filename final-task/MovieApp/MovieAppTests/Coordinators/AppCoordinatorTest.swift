//
//  AppCoordinatorTest.swift
//  MovieAppTests
//
//  Created by rasul on 11/19/21.
//

import XCTest
@testable import MovieApp

class AppCoordinatorTest: XCTestCase {
  private var router: RouterMock!
  private var coordinatorFactory: CoordinatorFactoryMock!
  private var screenFactory: ScreenFactoryMock!
  private var appCoordinator: AppCoordinatorProtocol!
  override func setUp() {
    super.setUp()
    router = RouterMock()
    screenFactory = ScreenFactoryMock()
    coordinatorFactory = CoordinatorFactoryMock()
    appCoordinator = AppCoordinator(router: router,
                                    screenFactory: screenFactory,
                                    coordinatorFactory: coordinatorFactory)
  }
  
  func test_pushAuth() {
    screenFactory.makeAuthScreenHandler = { _ in
      return AuthViewController()
    }
    
    self.coordinatorFactory.makeAuthCoordinatorHandler = { router in
      return AuthCoordinator(router: router,
                             coordinatorFactory: self.coordinatorFactory,
                             screenFactory: self.screenFactory)
    }
    
    appCoordinator.pushAuth()
    
    XCTAssertEqual(router.pushCallCount, 1)
    XCTAssertEqual(coordinatorFactory.makeAuthCoordinatorCallCount, 1)
    XCTAssertEqual(screenFactory.makeAuthScreenCallCount, 1)
  }
  
  func test_pushTabBar() {
    
    screenFactory.makeListsScreenHandler = { _, _ in
      return ListsViewController()
    }
    
    self.coordinatorFactory.makeListsCoordinatorHandler = { router, vc in
      return ListsCoordinator(router: router,
                              coordinatorFactory: self.coordinatorFactory,
                              screenFactory: self.screenFactory,
                              tabBarViewController: vc)
    }
    
    coordinatorFactory.makeTabBarCoordinatorHandler = { router in
      return TabBarCoordinator(router: router, screenFactory: self.screenFactory, coordinatorFactory: self.coordinatorFactory)
    }
    
    screenFactory.makeSearchScreenHandler = { _ in
      return SearchViewController()
    }
  
    coordinatorFactory.makeSearchCoordinatorHandler = { router, vc in
      return SearchCoordinator(router: router,
                               coordinatorFactory: self.coordinatorFactory,
                               screenFactory: self.screenFactory,
                               tabBarViewController: vc)
    }
    
    screenFactory.makeFavoriteScreenHandler = { _ in
      return FavoriteViewController()
    }
  
    coordinatorFactory.makeFavoriteCoordinatorHandler = { router, vc in
      return FavoriteCoordinator(router: router,
                                 coordinatorFactory: self.coordinatorFactory,
                                 screenFactory: self.screenFactory,
                                 tabBarViewController: vc)
    }
    
    appCoordinator.pushTabBar()
    
    XCTAssertEqual(router.setRootModuleHideBarCallCount, 1)
    XCTAssertEqual(coordinatorFactory.makeTabBarCoordinatorCallCount, 1)
    XCTAssertEqual(coordinatorFactory.makeListsCoordinatorCallCount, 1)
    XCTAssertEqual(coordinatorFactory.makeSearchCoordinatorCallCount, 1)
    XCTAssertEqual(coordinatorFactory.makeFavoriteCoordinatorCallCount, 1)
    XCTAssertEqual(screenFactory.makeListsScreenCallCount, 1)
    XCTAssertEqual(screenFactory.makeSearchScreenCallCount, 1)
    XCTAssertEqual(screenFactory.makeFavoriteScreenCallCount, 1)
  }
}
