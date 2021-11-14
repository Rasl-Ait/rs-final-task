//
//  SearchServiceSpy.swift
//  MovieAppTests
//
//  Created by rasul on 11/14/21.
//

import XCTest
@testable import MovieApp

class SearchServiceSpy: SearchServiceProtocol {
  var responseMovie: MovieResponce?
  
  func search(_ param: SearchParam, _ completion: @escaping CompletionBlock<MovieResponce>) {
    if let response = responseMovie {
      completion(.success(response))
    } else {
      let error = NSError(domain: "", code: 0, userInfo: nil)
      completion(.failure(.requestError(0, error.localizedDescription)))
    }
  }
  
}
