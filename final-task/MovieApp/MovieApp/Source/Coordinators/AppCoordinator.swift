//
//  AppCoordinator.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
  private let router: Router
  private let coordinatorFactory: CoordinatorFactory
  private let screenFactory: ScreenFactory
  
  init(
       router: Router,
       screenFactory: ScreenFactory,
       coordinatorFactory: CoordinatorFactory) {
    self.router = router
    self.screenFactory = screenFactory
    self.coordinatorFactory = coordinatorFactory
  }
  
  override func start() {
    if UserDefaults.standard.sessionID != "" {
      pushTabBar()
    } else {
      pushAuth()
    }
  }
  
  private func pushAuth() {
    let coordinator = coordinatorFactory.makeAuthCoordinator(router: router)
    addDependency(coordinator)
    coordinator.start()
  }
  
  private func pushTabBar() {
//    let listCoordinator = coordinatorFactory.makeListsCoordinator(
//      router: router,
//      tabBarViewController: TabBarController()
//    )
//    addDependency(listCoordinator)
//    listCoordinator.start()
    //router.setRootModule(tabBarController, hideBar: true)
    let coordinator = coordinatorFactory.makeTabBarCoordinator(router: router)
    addDependency(coordinator)
    coordinator.start()
  }
}
