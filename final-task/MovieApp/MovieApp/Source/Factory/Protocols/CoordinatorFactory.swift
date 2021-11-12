//
//  CoordinatorFactoryProtocol.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

import UIKit

protocol CoordinatorFactory {
  func makeAppCoordinator(router: Router) -> AppCoordinator
  func makeAuthCoordinator(router: Router) -> AuthCoordinator
  func makeTabBarCoordinator(router: Router) -> TabBarCoordinator
  func makeListsCoordinator(router: Router, tabBarViewController: TabBarController) -> ListsCoordinator
  func makeListDetailCoordinator(router: Router, list: ListModel) -> ListDetailCoordinator
}
