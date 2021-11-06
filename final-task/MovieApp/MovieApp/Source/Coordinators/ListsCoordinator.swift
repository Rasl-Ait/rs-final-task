//
//  ListsCoordinator.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//

import UIKit

protocol ListsCoordinatorProtocol: AnyObject {
}

final class ListsCoordinator: Coordinator {
  var children: [Coordinator] = []
  let router: Router
  let screenFactory: ScreenFactory
  let tabBarViewController: TabBarController
  
  init(router: Router, screenFactory: ScreenFactory, tabBarViewController: TabBarController) {
    self.router = router
    self.screenFactory = screenFactory
    self.tabBarViewController = tabBarViewController
  }
  
  func start() {
    pushLists()
  }
}

// MARK: - ListsCoordinator
extension ListsCoordinator: ListsCoordinatorProtocol {
   func pushLists() {
    let viewController = screenFactory.makeListsScreen(self)
    tabBarViewController.appendNavigationController(viewController, item: .home)
  }
}
