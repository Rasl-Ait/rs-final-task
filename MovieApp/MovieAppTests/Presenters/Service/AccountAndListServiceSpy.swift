//
//  AccountAndListServiceSpy.swift
//  MovieAppTests
//
//  Created by rasul on 11/14/21.
//
import XCTest
@testable import MovieApp

class AccountAndListServiceSpy: AccountAndListServiceProtocol {
  var responseList: ListResponce?
  var responseNewList: NewListResponce?
  var responseSuccessError: SuccessErrorModel?
  var responseAccount: AccountModel?
  var responseListDetail: ListDetailResponce?
  var responseMovie: MovieResponce?
  
   func getAccount(_ completion: @escaping CompletionBlock<AccountModel>) {
    if let response = responseAccount {
      completion(.success(response))
    } else {
      let error = NSError(domain: "", code: 0, userInfo: nil)
      completion(.failure(.requestError(0, error.localizedDescription)))
    }
  }
  
   func getLists(_ page: Int, completion: @escaping CompletionBlock<ListResponce>) {
    if let response = responseList {
      completion(.success(response))
    } else {
      let error = NSError(domain: "", code: 0, userInfo: nil)
      completion(.failure(.requestError(0, error.localizedDescription)))
    }
  }
  
   func createList(_ param: NewListParam, completion: @escaping CompletionBlock<NewListResponce>) {
    if let response = responseNewList {
      completion(.success(response))
    } else {
      let error = NSError(domain: "", code: 0, userInfo: nil)
      completion(.failure(.requestError(0, error.localizedDescription)))
    }
  }
  
   func deleteList(_ id: Int, completion: @escaping CompletionBlock<SuccessErrorModel>) {
    if let response = responseSuccessError {
      completion(.success(response))
    } else {
      let error = NSError(domain: "", code: 0, userInfo: nil)
      completion(.failure(.requestError(0, error.localizedDescription)))
    }
  }
  
   func movieToList(_ id: Int, param: MovieToListParam, completion: @escaping CompletionBlock<SuccessErrorModel>) {
    if let response = responseSuccessError {
      completion(.success(response))
    } else {
      let error = NSError(domain: "", code: 0, userInfo: nil)
      completion(.failure(.requestError(0, error.localizedDescription)))
    }
  }
  
   func listDetail(_ id: Int, completion: @escaping CompletionBlock<ListDetailResponce>) {
    if let response = responseListDetail {
      completion(.success(response))
    } else {
      let error = NSError(domain: "", code: 0, userInfo: nil)
      completion(.failure(.requestError(0, error.localizedDescription)))
    }
  }
  
   func removeMovie(_ id: Int, param: RemoveMovieParam, completion: @escaping CompletionBlock<SuccessErrorModel>) {
    if let response = responseSuccessError {
      completion(.success(response))
    } else {
      let error = NSError(domain: "", code: 0, userInfo: nil)
      completion(.failure(.requestError(0, error.localizedDescription)))
    }
  }
  
   func getFavoriteMovies(_ page: Int, completion: @escaping CompletionBlock<MovieResponce>) {
    if let response = responseMovie {
      completion(.success(response))
    } else {
      let error = NSError(domain: "", code: 0, userInfo: nil)
      completion(.failure(.requestError(0, error.localizedDescription)))
    }
  }
  
  func markAsFavorite(_ param: ListFavoriteParam, completion: @escaping CompletionBlock<SuccessErrorModel>) {
    if let response = responseSuccessError {
      completion(.success(response))
    } else {
      let error = NSError(domain: "", code: 0, userInfo: nil)
      completion(.failure(.requestError(0, error.localizedDescription)))
    }
  }
}
