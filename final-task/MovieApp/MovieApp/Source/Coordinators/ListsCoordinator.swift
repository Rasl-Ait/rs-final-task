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
  var finishFlow: VoidClosure? { get set }
  func pushAuthVC()
}

final class ListsCoordinator: BaseCoordinator {
  private let router: Router
  private let coordinatorFactory: CoordinatorFactory
  private let screenFactory: ScreenFactory
  var screenType: ScreenType = .home
  var finishFlow: VoidClosure?
  var mediaID: Int?

  init(
    router: Router,
    coordinatorFactory: CoordinatorFactory,
    screenFactory: ScreenFactory) {
    self.router = router
    self.screenFactory = screenFactory
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
    if screenType != .movieDetail {
      router.setRootModule(viewController)
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
    finishFlow?()
  }
  
  func pop() {
    router.popModule()
    finishFlow?()
  }
}
