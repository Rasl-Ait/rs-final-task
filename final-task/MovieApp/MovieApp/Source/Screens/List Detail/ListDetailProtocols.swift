//
//  ListDetailProtocols.swift
//  MovieApp
//
//  Created by rasul on 11/7/21.
//  
//

import Foundation

protocol ListDetailViewInput: AnyObject {
  func success(items: [MovieModel])
  func successRemoveMovie()
	func failure(error: APIError)
	func hideIndicator()
	func showIndicator()
}

protocol ListDetailViewOutput: AnyObject {
  var alertTitles: [String] { get }
  var title: String { get }
  
  func getMovies(state: StateLoad)
  func removeMovie(item: MovieModel)
  func push(id: Int)
  func viewWillDisappear()
}
