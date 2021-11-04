//
//  AppCoordinator.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

import UIKit

class AppCoordinator: Coordinator {
  var children: [Coordinator] = []
  let router: Router
  let screenFactory: ScreenFactoryProtocol
  
  init(router: Router, screenFactory: ScreenFactoryProtocol) {
    self.router = router
    self.screenFactory = screenFactory
  }
  
  func present(animated: Bool, onDismissed: (() -> Void)?) {
    let viewController = screenFactory.makeAuthScreen()
    router.present(viewController, animated: animated, onDismissed: onDismissed)
  }
}
