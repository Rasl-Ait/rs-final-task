//
//  AuthProtocols.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//  
//

import Foundation

protocol AuthViewInput: AnyObject {
	func success()
	func failure(error: Error)
	func hideIndicator()
	func showIndicator()
}

protocol AuthViewOutput: AnyObject {
  func newToken(_ param: AuthParam)
}
