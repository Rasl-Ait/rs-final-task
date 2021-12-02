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
    
    XCTAssertEqual(router.setRootModuleCallCount, 1)
    XCTAssertEqual(coordinatorFactory.makeAuthCoordinatorCallCount, 1)
    XCTAssertEqual(screenFactory.makeAuthScreenCallCount, 1)
  }
  
  func test_pushTabBar() {
    
    screenFactory.makeListsScreenHandler = { _, _ in
      return ListsViewController()
    }
    
    self.coordinatorFactory.makeListsCoordinatorHandler = { router in
      return ListsCoordinator(router: router,
                              coordinatorFactory: self.coordinatorFactory,
                              screenFactory: self.screenFactory)
    }
    
    coordinatorFactory.makeTabBarCoordinatorHandler = {
      let module = TabBarController()
      let coordinator = TabBarCoordinator(tabBarView: module, coordinatorFactory: self.coordinatorFactory)
      return (coordinator, module)
    }
    
    screenFactory.makeSearchScreenHandler = { _ in
      return SearchViewController()
    }
  
    coordinatorFactory.makeSearchCoordinatorHandler = { _ in
      return SearchCoordinator(router: self.router,
                               coordinatorFactory: self.coordinatorFactory,
                               screenFactory: self.screenFactory)
    }
    
    screenFactory.makeFavoriteScreenHandler = { _ in
      return FavoriteViewController()
    }
  
    coordinatorFactory.makeFavoriteCoordinatorHandler = { _ in
      return FavoriteCoordinator(router: self.router,
                                 coordinatorFactory: self.coordinatorFactory,
                                 screenFactory: self.screenFactory)
    }
    
    appCoordinator.pushTabBar()
    
    XCTAssertEqual(router.setRootModuleHideBarCallCount, 1)
    XCTAssertEqual(coordinatorFactory.makeTabBarCoordinatorCallCount, 1)
//    XCTAssertEqual(coordinatorFactory.makeListsCoordinatorCallCount, 1)
//    XCTAssertEqual(coordinatorFactory.makeSearchCoordinatorCallCount, 1)
//    XCTAssertEqual(coordinatorFactory.makeFavoriteCoordinatorCallCount, 1)
//    XCTAssertEqual(screenFactory.makeListsScreenCallCount, 1)
//    XCTAssertEqual(screenFactory.makeSearchScreenCallCount, 1)
//    XCTAssertEqual(screenFactory.makeFavoriteScreenCallCount, 1)
  }
}
