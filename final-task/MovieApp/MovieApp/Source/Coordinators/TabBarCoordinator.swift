//
//  TabBarCoordinator.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//

import UIKit

/// @mockable
protocol TabBarViewProtocol: AnyObject {
  var onListsFlowSelect: ItemClosure<NavigationController>? { get set }
  var onViewDidLoad: ItemClosure<NavigationController>? { get set }
  var onSearchFlowSelect: ItemClosure<NavigationController>? { get set }
  var onFavoriteFlowSelect: ItemClosure<NavigationController>? { get set }
}

final class TabBarCoordinator: BaseCoordinator {
  private let tabBarView: TabBarViewProtocol
  private let coordinatorFactory: CoordinatorFactory
  
  var finishFlow: VoidClosure?
  
  init(tabBarView: TabBarViewProtocol, coordinatorFactory: CoordinatorFactory ) {
    self.tabBarView = tabBarView
    self.coordinatorFactory = coordinatorFactory
  }
  
  override func start() {
    tabBarView.onViewDidLoad = runListsFlow()
    tabBarView.onListsFlowSelect = runListsFlow()
    tabBarView.onSearchFlowSelect = runSearchFlow()
    tabBarView.onFavoriteFlowSelect = runFavoriteFlow()
  }
  
  deinit {
    Log.logInfo(text: "Delete Tabbar coordinator")
  }
}

extension TabBarCoordinator {
  private func runListsFlow() -> ItemClosure<NavigationController> {
    return { [weak self] navigationController in
      guard let self = self,
            navigationController.viewControllers.isEmpty else { return }
      let router = RouterImp(rootController: navigationController)
      let coordinator = self.coordinatorFactory.makeListsCoordinator(router: router)
      
      coordinator.finishFlow = { [weak self] in
        guard let self = self else { return }
        self.finishFlow?()
      }
      
      self.addDependency(coordinator)
      coordinator.start()
    }
  }
  
  private func runSearchFlow() -> ItemClosure<NavigationController> {
    return { [weak self] navigationController in
      guard let self = self,
            navigationController.viewControllers.isEmpty else { return }
      let coordinator = self.coordinatorFactory.makeSearchCoordinator(navigationController: navigationController)
      
      self.addDependency(coordinator)
      coordinator.start()
    }
  }
  
  private func runFavoriteFlow() -> ItemClosure<NavigationController> {
    return { [weak self] navigationController in
      guard let self = self,
            navigationController.viewControllers.isEmpty else { return }
      let coordinator = self.coordinatorFactory.makeFavoriteCoordinator(navigationController: navigationController)
      
      self.addDependency(coordinator)
      coordinator.start()
    }
  }
}
