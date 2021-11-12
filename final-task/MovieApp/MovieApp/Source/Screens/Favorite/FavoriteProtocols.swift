//
//  FavoriteProtocols.swift
//  MovieApp
//
//  Created by rasul on 11/12/21.
//  
//

import Foundation

protocol FavoriteViewInput: AnyObject {
	func success()
	func failure(error: APIError)
	func hideIndicator()
	func showIndicator()
}

protocol FavoriteViewOutput: AnyObject {
}
