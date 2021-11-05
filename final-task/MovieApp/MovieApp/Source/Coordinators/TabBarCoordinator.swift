//
//  TabBarCooridnator.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//

import UIKit

final class TabBarCoordinator: Coordinator, ListsCoordinatorProtocol {
  var children: [Coordinator] = []
  let router: Router
  let coordinatorFactory: CoordinatorFactory
  let screenFactory: ScreenFactory
  
  init(router: Router, screenFactory: ScreenFactory, coordinatorFactory: CoordinatorFactory) {
    self.router = router
    self.screenFactory = screenFactory
    self.coordinatorFactory = coordinatorFactory
  }
  
  func start() {
    pushTabBar()
  }
}

extension TabBarCoordinator {
   func pushTabBar() {
    let tabBarController = TabBarController()
    let listCoordinator = coordinatorFactory.makeListsCoordinator(
      router: router,
      tabBarViewController: tabBarController
    )
    
    let view = listCoordinator.screenFactory.makeListsScreen(self)
    let navController = NavigationController(rootViewController: view)
    navController.navigationBar.prefersLargeTitles = true
    tabBarController.appendNavigationController(navController, item: .home)
    children.append(listCoordinator)
    router.setRootModule(tabBarController, hideBar: true)
  }
}
