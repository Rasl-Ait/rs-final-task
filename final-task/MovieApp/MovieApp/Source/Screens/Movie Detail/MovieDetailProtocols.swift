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
}

protocol MovieDetailViewInput: AnyObject {
  func success(type: DetailContentType)
	func failure(error: Error)
	func hideIndicator()
	func showIndicator()
}

protocol MovieDetailViewOutput: AnyObject {
  func getMovie()
}
