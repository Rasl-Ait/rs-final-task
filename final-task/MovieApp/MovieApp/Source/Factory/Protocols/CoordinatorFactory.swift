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
  func makeAuthCoordinator(router: Router) -> AuthCoordinator
  func makeTabBarCoordinator() -> (coordinator: TabBarCoordinator, toPresent: Presentable)
  func makeListsCoordinator(router: Router) -> ListsCoordinator
  func makeListDetailCoordinator(router: Router, list: ListModel) -> ListDetailCoordinator
  func makeMovieDetailCoordinator(router: Router, movieID: Int) -> MovieDetailCoordinator
  func makeSearchCoordinator(navigationController: NavigationController) -> SearchCoordinator
  func makeFavoriteCoordinator(navigationController: NavigationController) -> FavoriteCoordinator
}
