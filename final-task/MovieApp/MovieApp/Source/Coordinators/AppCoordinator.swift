//
//  AppCoordinator.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

import UIKit

final class AppCoordinator: Coordinator {
  var children: [Coordinator] = []
  let router: Router
  let coordinatorFactory: CoordinatorFactory
  let screenFactory: ScreenFactory
  
  init(
       router: Router,
       screenFactory: ScreenFactory,
       coordinatorFactory: CoordinatorFactory) {
    self.router = router
    self.screenFactory = screenFactory
    self.coordinatorFactory = coordinatorFactory
  }
  
  func start() {
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
    let coordinator = coordinatorFactory.makeTabBarCoordinator(router: router)
    addDependency(coordinator)
    coordinator.start()
  }
}
