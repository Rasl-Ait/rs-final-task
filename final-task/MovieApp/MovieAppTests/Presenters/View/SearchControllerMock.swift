//
//  SearchControllerMock.swift
//  MovieAppTests
//
//  Created by rasul on 11/14/21.
//

import XCTest
@testable import MovieApp

class SearchControllerMock: SearchViewInput {
  var isCalledSuccess: Bool!
  
  func success(items: [MovieModel]) {
    isCalledSuccess = true
  }

  func failure(error: APIError) {
    isCalledSuccess = false

  }
  
  func hideIndicator() {
    
  }
  
  func showIndicator() {
    
  }
}
