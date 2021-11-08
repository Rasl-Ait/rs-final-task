//
//  ListsCoordinator.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//

import UIKit

protocol ListsCoordinatorProtocol: AnyObject {
  func pushListDetailVC(list: ListModel)
}

final class ListsCoordinator: BaseCoordinator {
  let router: Router
  let coordinatorFactory: CoordinatorFactory
  let screenFactory: ScreenFactory
  let tabBarViewController: TabBarController
  
  init(
    router: Router,
    coordinatorFactory: CoordinatorFactory,
    screenFactory: ScreenFactory,
    tabBarViewController: TabBarController) {
    self.router = router
    self.screenFactory = screenFactory
    self.tabBarViewController = tabBarViewController
    self.coordinatorFactory = coordinatorFactory
  }
  
  override func start() {
    pushLists()
  }
}

// MARK: - ListsCoordinator
extension ListsCoordinator: ListsCoordinatorProtocol {
   func pushLists() {
    let viewController = screenFactory.makeListsScreen(self)
    // let navController = NavigationController(rootViewController: viewController)
    router.setRootModule(viewController)

  }
  
  func pushListDetailVC(list: ListModel) {
    let child = coordinatorFactory.makeListDetailCoordinator(router: router, list: list)
    
    child.finishFlow = { [weak self, weak child] in
      guard let self = self else { return }
      self.removeChildCoordinator(child)
    }
    addDependency(child)
    child.start()
  }
}
