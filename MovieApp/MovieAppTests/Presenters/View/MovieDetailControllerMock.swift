//
//  MovieDetailControllerMock.swift
//  MovieAppTests
//
//  Created by rasul on 11/14/21.
//

import XCTest
@testable import MovieApp

class MovieDetailControllerMock: MovieDetailViewInput {
  
  var isCalledSuccess: Bool!
  
  func success(type: DetailContentType) {
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
