//
//  AuthCoordinator.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//

import UIKit

protocol AuthCoordinatorProtocol: AnyObject {
  func pushTabBar()
}

final class AuthCoordinator: Coordinator {
  var children: [Coordinator] = []
  let router: Router
  let screenFactory: ScreenFactory
  let coordinatorFactory: CoordinatorFactory
  
  init(
    router: Router,
    coordinatorFactory: CoordinatorFactory,
    screenFactory: ScreenFactory) {
    self.router = router
    self.screenFactory = screenFactory
    self.coordinatorFactory = coordinatorFactory
  }
  
  func start() {
    pushAuth()
  }
}

// MARK: - AuthCoordinatorProtocol
extension AuthCoordinator: AuthCoordinatorProtocol {
   func pushAuth() {
    let viewController = screenFactory.makeAuthScreen(self)
    router.setRootModule(viewController)
  }
  
   func pushTabBar() {
    let coordinator = coordinatorFactory.makeTabBarCoordinator(router: router)
    addDependency(coordinator)
    coordinator.start()
  }
}
