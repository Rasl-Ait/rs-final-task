//
//  AuthProtocols.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//  
//

import Foundation

/// @mockable
protocol AuthViewInput: AnyObject {
	func success()
	func failure(error: APIError)
	func hideIndicator()
	func showIndicator()
}
/// @mockable
protocol AuthViewOutput: AnyObject {
  func newToken(_ param: AuthParam)
}
