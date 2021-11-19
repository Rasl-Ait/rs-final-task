//
//  ListsCoordinator.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//

import UIKit

/// @mockable
protocol ListsCoordinatorProtocol: AnyObject {
  func pop()
  func pushListDetailVC(list: ListModel)
  func pushAuthVC()
}

final class ListsCoordinator: BaseCoordinator {
  private let router: Router
  private let coordinatorFactory: CoordinatorFactory
  private let screenFactory: ScreenFactory
  let tabBarViewController: TabBarController
  var screenType: ScreenType = .home
  var finishFlow: VoidClosure?
  var mediaID: Int?

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
    let viewController = screenFactory.makeListsScreen(self, mediaID: mediaID)
     let navController = NavigationController(rootViewController: viewController)
    if screenType != .movieDetail {
      tabBarViewController.appendNavigationController(navController, item: .home)
    } else {
      router.push(viewController, animated: true)
    }
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
  
  func pushAuthVC() {
    tabBarViewController.viewControllers?.removeAll()
    let coordinator = coordinatorFactory.makeAuthCoordinator(router: router)
    addDependency(coordinator)
    coordinator.start()
  }
  
  func pop() {
    router.popModule()
    finishFlow?()
  }
}
