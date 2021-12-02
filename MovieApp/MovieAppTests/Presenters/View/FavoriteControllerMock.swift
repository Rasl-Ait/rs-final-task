//
//  FavoriteControllerMock.swift
//  MovieAppTests
//
//  Created by rasul on 11/14/21.
//

import XCTest
@testable import MovieApp

class FavoriteControllerMock: FavoriteViewInput {
  
  var isCalledSuccess: Bool!
  var isDeleteSuccess: Bool!
  
  func success(items: [MovieModel], state: StateLoad) {
    isCalledSuccess = true
  }
  
  func successDeleteMovie() {
    isDeleteSuccess = true
  }

  func failure(error: APIError) {
    isCalledSuccess = false
    isDeleteSuccess = false
  }
  
  func hideIndicator() {
    
  }
  
  func showIndicator() {
    
  }
}
