//
//  ScreenFactory.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

import Foundation

protocol ScreenFactory {
  func makeAuthScreen(_ coordinator: AuthCoordinatorProtocol) -> AuthViewController
  func makeListsScreen(_ coordinator: ListsCoordinatorProtocol) -> ListsViewController
  func makeListDetailScreen(_ coordinator: ListDetailCoordinatorProtocol, list: ListModel) -> ListDetailViewController
}
