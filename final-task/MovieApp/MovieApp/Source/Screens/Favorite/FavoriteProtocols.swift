//
//  FavoriteProtocols.swift
//  MovieApp
//
//  Created by rasul on 11/12/21.
//  
//

import Foundation

protocol FavoriteViewInput: AnyObject {
  func success(items: [MovieModel], state: StateLoad)
  func successDeleteMovie()
	func failure(error: APIError)
	func hideIndicator()
	func showIndicator()
}

protocol FavoriteViewOutput: AnyObject {
  func didSelect(type: FavoriteTappedType)
  func getFavoriteMovie(state: StateLoad)
}
