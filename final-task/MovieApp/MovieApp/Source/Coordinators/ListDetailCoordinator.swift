//
//  ListDetailCoordinator.swift
//  MovieApp
//
//  Created by rasul on 11/7/21.
//

import UIKit

protocol ListDetailCoordinatorProtocol: AnyObject {
  func pop()
  func pushMovieDetailVC(id: Int)
}

final class ListDetailCoordinator: BaseCoordinator {
  private let router: Router
  private let coordinatorFactory: CoordinatorFactory
  private let screenFactory: ScreenFactory
  private let list: ListModel
  
  var finishFlow: VoidClosure?
  
  init(router: Router, coordinatorFactory: CoordinatorFactory, screenFactory: ScreenFactory, list: ListModel) {
    self.router = router
    self.screenFactory = screenFactory
    self.list = list
    self.coordinatorFactory = coordinatorFactory
  }
  
  override func start() {
    pushListDetail()
  }
  
  deinit {
    print("delete coordinator List detail")
  }
}

// MARK: - ListDetailCoordinator
extension ListDetailCoordinator: ListDetailCoordinatorProtocol {
   func pushListDetail() {
    let viewController = screenFactory.makeListDetailScreen(self, list: list)
    router.push(viewController)
  }
  
  func pop() {
    router.popModule()
    finishFlow?()
  }
  
  func pushMovieDetailVC(id: Int) {
    let coordinator = coordinatorFactory.makeMovieDetailCoordinator(router: router, movieID: id)
    coordinator.finishFlow = { [weak self, weak coordinator] in
      guard let self = self else { return }
      self.removeChildCoordinator(coordinator)
    }
    
    addDependency(coordinator)
    coordinator.start()
  }
}
