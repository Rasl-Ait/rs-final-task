//
//  AppCoordinator.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

import UIKit

protocol AppCoordinatorProtocol: AnyObject {
  func pushAuth()
  func pushTabBar()
}

final class AppCoordinator: BaseCoordinator, AppCoordinatorProtocol {
  private let router: Router
  private let coordinatorFactory: CoordinatorFactory
  
  init(
    router: Router,
    coordinatorFactory: CoordinatorFactory) {
      self.router = router
      self.coordinatorFactory = coordinatorFactory
    }
  
  override func start() {
    if UserDefaults.standard.sessionID != "" {
      pushTabBar()
    } else {
      pushAuth()
    }
  }
  
  func pushAuth() {
    let coordinator = coordinatorFactory.makeAuthCoordinator(router: router)
    
    coordinator.finishFlow = { [weak self, weak coordinator] in
      guard let self = self else { return }
      self.start()
      self.removeChildCoordinator(coordinator)
     
    }
    
    addDependency(coordinator)
    coordinator.start()
  }
  
  func pushTabBar() {
    let (coordinator, module) = coordinatorFactory.makeTabBarCoordinator()
    
    coordinator.finishFlow = { [weak self, weak coordinator] in
      guard let self = self else { return }
      self.start()
      self.removeChildCoordinator(coordinator)
    }
    
    addDependency(coordinator)
    router.setRootModule(module, hideBar: true)
    coordinator.start()
  }
}
