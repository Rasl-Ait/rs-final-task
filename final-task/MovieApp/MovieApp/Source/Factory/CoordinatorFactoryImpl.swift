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
    AppCoordinator(router: router, coordinatorFactory: self)
  }
  
  func makeAuthCoordinator(router: Router) -> AuthCoordinator {
    AuthCoordinator(router: router, coordinatorFactory: self, screenFactory: screenFactory)
  }
  
  func makeTabBarCoordinator() -> (coordinator: TabBarCoordinator, toPresent: Presentable) {
    let controller = TabBarController()
    let coordinator = TabBarCoordinator(tabBarView: controller, coordinatorFactory: self)
    return (coordinator, controller)
  }
  
  func makeListsCoordinator(router: Router) -> ListsCoordinator {
    return ListsCoordinator(
      router: router,
      coordinatorFactory: self,
      screenFactory: screenFactory
    )
  }
  
  func makeListDetailCoordinator(router: Router, list: ListModel) -> ListDetailCoordinator {
    ListDetailCoordinator(router: router, coordinatorFactory: self, screenFactory: screenFactory, list: list)
  }
  
  func makeMovieDetailCoordinator(router: Router, movieID: Int) -> MovieDetailCoordinator {
    MovieDetailCoordinator(router: router, coordinatorFactory: self, screenFactory: screenFactory, movieID: movieID)
  }
  
  func makeSearchCoordinator(navigationController: NavigationController) -> SearchCoordinator {
    let router = RouterImp(rootController: navigationController)
    return SearchCoordinator(router: router,
                             coordinatorFactory: self,
                             screenFactory: screenFactory)
  }
  
  func makeFavoriteCoordinator(navigationController: NavigationController) -> FavoriteCoordinator {
    let router = RouterImp(rootController: navigationController)
    return FavoriteCoordinator(router: router, coordinatorFactory: self,
                               screenFactory: screenFactory)
  }
}
