//
//  CoordinatorFactoryProtocol.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

import UIKit

/// @mockable
protocol CoordinatorFactory {
  func makeAppCoordinator(router: Router) -> AppCoordinator
  func makeTabBarCoordinator() -> (coordinator: TabBarCoordinator, toPresent: Presentable)
  func makeAuthCoordinator(router: Router) -> AuthCoordinator & AuthCoordinatorProtocol
  func makeListsCoordinator(router: Router) -> ListsCoordinator & ListsCoordinatorProtocol
  func makeListDetailCoordinator(router: Router, list: ListModel) -> ListDetailCoordinator & ListDetailCoordinatorProtocol
  func makeMovieDetailCoordinator(router: Router, movieID: Int) -> MovieDetailCoordinator & MovieDetailCoordinatorProtocol
  func makeSearchCoordinator(navigationController: NavigationController) -> SearchCoordinator & SearchCoordinatorProtocol
  func makeFavoriteCoordinator(navigationController: NavigationController) -> FavoriteCoordinator & FavoriteCoordinatorProtocol
}
