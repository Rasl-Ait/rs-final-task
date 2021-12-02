//
//  SearchCoordinator.swift
//  MovieApp
//
//  Created by rasul on 11/12/21.
//

import UIKit

/// @mockable
protocol SearchCoordinatorProtocol: AnyObject {
  func pop()
  func pushMovieDetailVC(id: Int)
  var finishFlow: VoidClosure? { get set }
}

final class SearchCoordinator: BaseCoordinator, SearchCoordinatorProtocol {
  private let router: Router
  private let coordinatorFactory: CoordinatorFactory
  private let screenFactory: ScreenFactory
  
  var finishFlow: VoidClosure?
  
  init(router: Router,
       coordinatorFactory: CoordinatorFactory,
       screenFactory: ScreenFactory) {
    self.router = router
    self.screenFactory = screenFactory
    self.coordinatorFactory = coordinatorFactory
  }
  
  override func start() {
    pushSearch()
  }
  
  deinit {
    Log.logInfo(text: "Delete search coordinator")
  }
}

// MARK: - SearchCoordinator
extension SearchCoordinator {
   func pushSearch() {
    let viewController = screenFactory.makeSearchScreen(self)
     router.setRootModule(viewController)
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
