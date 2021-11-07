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
	func failure(error: Error)
	func hideIndicator()
	func showIndicator()
}

protocol ListDetailViewOutput: AnyObject {
  var alertTitles: [String] { get }
}
