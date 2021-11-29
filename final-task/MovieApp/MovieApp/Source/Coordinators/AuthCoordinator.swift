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
  func pushTabBar()
}

final class AuthCoordinator: BaseCoordinator {
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
}

// MARK: - AuthCoordinatorProtocol
extension AuthCoordinator: AuthCoordinatorProtocol {
  func pushAuth() {
    let viewController = screenFactory.makeAuthScreen(self)
    router.push(viewController)
  }
  
  func pushTabBar() {
    finishFlow?()
  }
}
