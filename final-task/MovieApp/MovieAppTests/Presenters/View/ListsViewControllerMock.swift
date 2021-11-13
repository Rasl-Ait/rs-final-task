//
//  File.swift
//  MovieAppTests
//
//  Created by rasul on 11/14/21.
//

import XCTest
@testable import MovieApp

class ListsViewControllerMock: ListsViewInput {
  
  var isCalledFetchLists: Bool!
  var isCalledCreateNewList: Bool!
  var isCalledDeleteList: Bool!
  var isCalledMovieToList: Bool!
  var isCalledAccount: Bool!
  
  func success(items: [ListModel]) {
    isCalledFetchLists = true
  }
  
  func successCreateList(text: String) {
    isCalledCreateNewList = true
  }
  
  func successDeleteList(text: String) {
    isCalledDeleteList = true
  }
  
  func successAddMovieToList(text: String) {
    isCalledMovieToList = true
  }
  
  func failure(error: APIError) {
    isCalledFetchLists = false
    isCalledDeleteList = false
    isCalledCreateNewList = false
    isCalledMovieToList = false
    isCalledAccount = false
  }
  
  func hideIndicator() {
    
  }
  
  func showIndicator() {
    
  }
}
