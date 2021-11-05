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
  
  init(router: Router, screenFactory: ScreenFactory) {
    self.router = router
    self.screenFactory = screenFactory
  }
  
  func present(animated: Bool, onDismissed: VoidClosure?) {
      pushAuth(animated: animated, onDismissed: onDismissed)
  }
}

// MARK: - AuthCoordinatorProtocol
extension AuthCoordinator: AuthCoordinatorProtocol {
   func pushAuth(animated: Bool, onDismissed: VoidClosure?) {
    let viewController = screenFactory.makeAuthScreen(self)
    router.present(viewController, animated: animated, onDismissed: onDismissed)
  }
  
   func pushTabBar() {
    let mainTabBarController = TabBarController()
    router.present(mainTabBarController, animated: true)
  }
}
