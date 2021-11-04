//
//  Router.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

import UIKit

protocol Router: AnyObject {
  func present(_ viewController: UIViewController, animated: Bool)
  func present(
    _ viewController: UIViewController,
    animated: Bool,
    onDismissed: VoidClosure?)
  func dismiss(animated: Bool)
}

extension Router {
  func present(
    _ viewController: UIViewController,
    animated: Bool) {
    present(viewController, animated: animated, onDismissed: nil)
  }
}
