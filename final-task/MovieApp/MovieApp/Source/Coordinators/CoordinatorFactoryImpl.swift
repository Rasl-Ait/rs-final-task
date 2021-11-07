//
//  CoordinatorFactoryImpl.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

import UIKit

final class CoordinatorFactoryImpl: CoordinatorFactory {
  private let screenFactory: ScreenFactory
  
  init(screenFactory: ScreenFactory) {
      self.screenFactory = screenFactory
  }
  
  func makeAppCoordinator(router: Router) -> AppCoordinator {
    AppCoordinator(router: router, screenFactory: screenFactory, coordinatorFactory: self)
  }
  
  func makeAuthCoordinator(router: Router) -> AuthCoordinator {
    AuthCoordinator(router: router, coordinatorFactory: self, screenFactory: screenFactory)
  }
  
  func makeTabBarCoordinator(router: Router) -> TabBarCoordinator {
    TabBarCoordinator(router: router, screenFactory: screenFactory, coordinatorFactory: self)
  }
  
  func makeListsCoordinator(router: Router, tabBarViewController: TabBarController) -> ListsCoordinator {
    ListsCoordinator(
      router: router,
      coordinatorFactory: self,
      screenFactory: screenFactory,
      tabBarViewController: tabBarViewController
    )
  }
  
  func makeListDetailCoordinator(router: Router, list: ListModel) -> ListDetailCoordinator {
    ListDetailCoordinator(router: router, screenFactory: screenFactory, list: list)
  }
}
