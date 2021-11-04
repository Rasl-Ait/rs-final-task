//
//  AppDelegateRouter.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

import UIKit

final class AppDelegateRouter: Router {
  
  public let window: UIWindow
  
  public init(window: UIWindow) {
    self.window = window
  }
  
  public func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
    window.rootViewController = viewController
    window.makeKeyAndVisible()
  }
  
  public func dismiss(animated: Bool) {
    // don't do anything
  }
}
