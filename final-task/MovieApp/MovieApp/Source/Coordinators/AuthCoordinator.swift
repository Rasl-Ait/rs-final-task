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

final class AuthCoordinator: BaseCoordinator {
  private let router: Router
  private let screenFactory: ScreenFactory
  private let coordinatorFactory: CoordinatorFactory
  
  init(
    router: Router,
    coordinatorFactory: CoordinatorFactory,
    screenFactory: ScreenFactory) {
    self.router = router
    self.screenFactory = screenFactory
    self.coordinatorFactory = coordinatorFactory
  }
  
  override func start() {
    pushAuth()
  }
}

// MARK: - AuthCoordinatorProtocol
extension AuthCoordinator: AuthCoordinatorProtocol {
   func pushAuth() {
    let viewController = screenFactory.makeAuthScreen(self)
    router.push(viewController)
  }
  
   func pushTabBar() {
    let coordinator = coordinatorFactory.makeTabBarCoordinator(router: router)

    addDependency(coordinator)
    coordinator.start()
  }
}
