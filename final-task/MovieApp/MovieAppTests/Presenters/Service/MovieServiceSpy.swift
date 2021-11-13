//
//  MovieServiceSpy.swift
//  MovieAppTests
//
//  Created by rasul on 11/14/21.
//

import XCTest
@testable import MovieApp

class MovieServiceSpy: MovieServiceProtocol {
  
  var responseMovieDetail: MovieDetailModel?
  var responseVideo: ResultsVideo?
  var responseSuccessError: SuccessErrorModel?
  var responseMovie: MovieResponce?
  var responseMovieState: MovieStates?
  
  func getMovie(_ id: Int, _ completion: @escaping CompletionBlock<MovieDetailModel>) {
    if let response = responseMovieDetail {
      completion(.success(response))
    } else {
      let error = NSError(domain: "", code: 0, userInfo: nil)
      completion(.failure(.requestError(0, error.localizedDescription)))
    }
  }
  
  func getVideo(_ id: Int, completion: @escaping CompletionBlock<ResultsVideo>) {
    if let response = responseVideo {
      completion(.success(response))
    } else {
      let error = NSError(domain: "", code: 0, userInfo: nil)
      completion(.failure(.requestError(0, error.localizedDescription)))
    }
  }
  
  func getMovieSimilar(_ id: Int, page: Int, completion: @escaping CompletionBlock<MovieResponce>) {
    if let response = responseMovie {
      completion(.success(response))
    } else {
      let error = NSError(domain: "", code: 0, userInfo: nil)
      completion(.failure(.requestError(0, error.localizedDescription)))
    }
  }
  
  func movieRate(_ id: Int, param: MovieRateParam, completion: @escaping CompletionBlock<SuccessErrorModel>) {
    if let response = responseSuccessError {
      completion(.success(response))
    } else {
      let error = NSError(domain: "", code: 0, userInfo: nil)
      completion(.failure(.requestError(0, error.localizedDescription)))
    }
  }
  
  func getAccountStates(_ id: Int, completion: @escaping CompletionBlock<MovieStates>) {
    if let response = responseMovieState {
      completion(.success(response))
    } else {
      let error = NSError(domain: "", code: 0, userInfo: nil)
      completion(.failure(.requestError(0, error.localizedDescription)))
    }
  }
}
