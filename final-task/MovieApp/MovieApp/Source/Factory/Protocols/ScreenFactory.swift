//
//  ScreenFactory.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

import Foundation

protocol ScreenFactory {
  func makeAuthScreen(_ coordinator: AuthCoordinatorProtocol) -> AuthViewController
  func makeListsScreen(_ coordinator: ListsCoordinatorProtocol, mediaID: Int?) -> ListsViewController
  func makeListDetailScreen(_ coordinator: ListDetailCoordinatorProtocol, list: ListModel) -> ListDetailViewController
  func makeMovieDetailScreen(_ coordinator: MovieDetailCoordinatorProtocol, id: Int) -> MovieDetailViewController
  func makeWebViewScreen(_ coordinator: MovieDetailCoordinatorProtocol, stringURL: String) -> WebViewController
  func makeSearchScreen(_ coordinator: SearchCoordinatorProtocol) -> SearchViewController
}
