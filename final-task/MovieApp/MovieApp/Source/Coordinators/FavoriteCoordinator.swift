//
//  FavoriteCoordinator.swift
//  MovieApp
//
//  Created by rasul on 11/12/21.
//

import UIKit

protocol FavoriteCoordinatorProtocol: AnyObject {
  func pop()
  func pushMovieDetailVC(id: Int)
}

final class FavoriteCoordinator: BaseCoordinator {
  private let router: Router
  private let coordinatorFactory: CoordinatorFactory
  private let screenFactory: ScreenFactory
  private let tabBarViewController: TabBarController
  
  var finishFlow: VoidClosure?
  
  init(router: Router,
       coordinatorFactory: CoordinatorFactory,
       screenFactory: ScreenFactory,
       tabBarViewController: TabBarController) {
    self.router = router
    self.screenFactory = screenFactory
    self.coordinatorFactory = coordinatorFactory
    self.tabBarViewController = tabBarViewController
  }
  
  override func start() {
    pushFavorite()
  }
}

// MARK: - FavoriteCoordinator
extension FavoriteCoordinator: FavoriteCoordinatorProtocol {
   func pushFavorite() {
    let viewController = screenFactory.makeFavoriteScreen(self)
    let navVC = NavigationController(rootViewController: viewController)
    tabBarViewController.appendNavigationController(navVC, item: .favorite)
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
