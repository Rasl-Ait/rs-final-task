//
//  ListsProtocols.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//  
//

import Foundation

protocol ListsViewInput: AnyObject {
  func success(items: [ListModel])
	func failure(error: Error)
	func hideIndicator()
	func showIndicator()
}

protocol ListsViewOutput: AnyObject {
  var lists: [ListModel] { get }
  
 func getLists()
}
