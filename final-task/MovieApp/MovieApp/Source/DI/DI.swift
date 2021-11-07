//
//  DI.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//

import UIKit

final class NavigationController: UINavigationController {
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationBar.setTitleFont(.avenir(.fontML, .Bold), color: .titleColor)
    navigationBar.setLargeTitleFont(.avenir(.fontXXXL, .Bold), color: .titleColor)
    navigationBar.barTintColor = .background
    navigationBar.tintColor = .titleColor
    navigationBar.isTranslucent = false
    view.backgroundColor = .background
    
    var attrs3 = [NSAttributedString.Key: Any]()
    attrs3[.foregroundColor] = UIColor.titleColor.withAlphaComponent(0.5)
    
    UIBarButtonItem.appearance().setTitleTextAttributes(attrs3, for: .disabled)
    UIBarButtonItem.appearance().setTitleTextAttributes(attrs3, for: .highlighted)
  }
}

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
