//
//  DI.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//

import UIKit

final class Di {
  // fileprivate let apiClient: HTTPClient
  fileprivate let screenFactory: ScreenFactoryImpl
  fileprivate let coordinatorFactory: CoordinatorFactoryImpl
  
  init() {
    screenFactory = ScreenFactoryImpl()
    coordinatorFactory = CoordinatorFactoryImpl(screenFactory: screenFactory)
  }
}

protocol AppFactory {
  func makeKeyWindowWithCoordinator(window: UIWindow) -> AppCoordinator
}

extension Di: AppFactory {
  func makeKeyWindowWithCoordinator(window: UIWindow) -> AppCoordinator {
    let rootVC = NavigationController()
    let router = RouterImp(rootController: rootVC)
    let coordinator = coordinatorFactory.makeAppCoordinator(router: router)
    window.rootViewController = rootVC
    window.makeKeyAndVisible()
    return coordinator
  }
}
