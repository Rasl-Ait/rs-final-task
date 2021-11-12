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
    ListDetailCoordinator(router: router, coordinatorFactory: self, screenFactory: screenFactory, list: list)
  }
  
  func makeMovieDetailCoordinator(router: Router, movieID: Int) -> MovieDetailCoordinator {
    MovieDetailCoordinator(router: router, coordinatorFactory: self, screenFactory: screenFactory, movieID: movieID)
  }
  
  func makeSearchCoordinator(router: Router, tabBarViewController: TabBarController) -> SearchCoordinator {
    SearchCoordinator(router: router, coordinatorFactory: self, screenFactory: screenFactory, tabBarViewController: tabBarViewController)
  }
  
  func makeFavoriteCoordinator(router: Router, tabBarViewController: TabBarController) -> FavoriteCoordinator {
    FavoriteCoordinator(router: router, coordinatorFactory: self, screenFactory: screenFactory, tabBarViewController: tabBarViewController)
  }
}
