//
//  MovieDetailProtocols.swift
//  MovieApp
//
//  Created by rasul on 11/10/21.
//  
//

import Foundation

protocol MovieDetailViewInput: class {
	func success()
	func failure(error: Error)
	func hideIndicator()
	func showIndicator()
}

protocol MovieDetailViewOutput: class {
}

protocol MovieDetailRouterInput: class {
}

protocol MovieDetailConfiguratorInput: class {
	func configure(_ viewController: MovieDetailViewController)
}

