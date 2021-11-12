//
//  MovieDetailProtocols.swift
//  MovieApp
//
//  Created by rasul on 11/10/21.
//  
//

import Foundation

enum DetailContentType {
  case movie(MovieDetailModel)
  case video([MovieVideo])
  case similarVideo([MovieModel])
  case favorite(Bool)
}

protocol MovieDetailViewInput: AnyObject {
  func success(type: DetailContentType)
	func failure(error: APIError)
	func hideIndicator()
	func showIndicator()
}

protocol MovieDetailViewOutput: AnyObject {
  var movieID: Int { get }
  
  func getMovie(id: Int)
  func didButtonClicked(type: BlurButtonType)
}
