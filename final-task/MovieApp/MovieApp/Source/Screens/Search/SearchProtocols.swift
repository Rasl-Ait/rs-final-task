//
//  SearchProtocols.swift
//  MovieApp
//
//  Created by rasul on 11/12/21.
//  
//

import Foundation

protocol SearchViewInput: AnyObject {
  func success(items: [MovieModel])
	func failure(error: APIError)
	func hideIndicator()
	func showIndicator()
}

protocol SearchViewOutput: AnyObject {
  func search(searchText: String)
  func push(id: Int)
}
