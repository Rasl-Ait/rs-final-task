//
//  AuthCoordinator.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//

import UIKit

/// @mockable
protocol AuthCoordinatorProtocol: AnyObject {
  var finishFlow: VoidClosure? { get set }
}

final class AuthCoordinator: BaseCoordinator, AuthCoordinatorProtocol {
  private let router: Router
  private let screenFactory: ScreenFactory
  private let coordinatorFactory: CoordinatorFactory
  
  var finishFlow: VoidClosure?
  
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
  
  deinit {
    print("Delete Auth Coordinator")
  }
}

// MARK: - AuthCoordinatorProtocol
extension AuthCoordinator {
  func pushAuth() {
    let viewController = screenFactory.makeAuthScreen(self)
    router.setRootModule(viewController)
  }
}
