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
  
  init(router: Router, screenFactory: ScreenFactory, coordinatorFactory: CoordinatorFactory) {
    self.router = router
    self.screenFactory = screenFactory
    self.coordinatorFactory = coordinatorFactory
  }
  
  func present(animated: Bool, onDismissed: VoidClosure?) {
    if UserDefaults.standard.sessionID != "" {
      pushTabBar(animated: animated, onDismissed: onDismissed)
    } else {
      pushAuth(animated: animated, onDismissed: onDismissed)
    }
  }
  
  private func pushAuth(animated: Bool, onDismissed: VoidClosure?) {
    let authCoordinator = coordinatorFactory.makeAuthCoordinator(router, screenFactory: screenFactory)
    presentChild(authCoordinator, animated: true)
  }
  
  private func pushTabBar(animated: Bool, onDismissed: VoidClosure?) {
    let mainTabBarController = TabBarController()
    router.present(mainTabBarController, animated: animated, onDismissed: onDismissed)
  }
}
