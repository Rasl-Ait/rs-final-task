//
//  AccountAndListServiceSpy.swift
//  MovieAppTests
//
//  Created by rasul on 11/14/21.
//
import XCTest
@testable import MovieApp

class AccountAndListServiceSpy: AccountAndListService {
  
  var responseList: ListResponce?
  var responseNewList: NewListResponce?
  var responseSuccessError: SuccessErrorModel?
  var responseAccount: AccountModel?
  var responseListDetail: ListDetailResponce?
  var responseMovie: MovieResponce?
  
  override func getAccount(_ completion: @escaping CompletionBlock<AccountModel>) {
    if let response = responseAccount {
      completion(.success(response))
    } else {
      let error = NSError(domain: "", code: 0, userInfo: nil)
      completion(.failure(.requestError(0, error.localizedDescription)))
    }
  }
  
  override func getLists(_ page: Int, completion: @escaping CompletionBlock<ListResponce>) {
    if let response = responseList {
      completion(.success(response))
    } else {
      let error = NSError(domain: "", code: 0, userInfo: nil)
      completion(.failure(.requestError(0, error.localizedDescription)))
    }
  }
  
  override func createList(_ param: NewListParam, completion: @escaping CompletionBlock<NewListResponce>) {
    if let response = responseNewList {
      completion(.success(response))
    } else {
      let error = NSError(domain: "", code: 0, userInfo: nil)
      completion(.failure(.requestError(0, error.localizedDescription)))
    }
  }
  
  override func deleteList(_ id: Int, completion: @escaping CompletionBlock<SuccessErrorModel>) {
    if let response = responseSuccessError {
      completion(.success(response))
    } else {
      let error = NSError(domain: "", code: 0, userInfo: nil)
      completion(.failure(.requestError(0, error.localizedDescription)))
    }
  }
  
  override func movieToList(_ id: Int, param: MovieToListParam, completion: @escaping CompletionBlock<SuccessErrorModel>) {
    if let response = responseSuccessError {
      completion(.success(response))
    } else {
      let error = NSError(domain: "", code: 0, userInfo: nil)
      completion(.failure(.requestError(0, error.localizedDescription)))
    }
  }
  
  override func listDetail(_ id: Int, completion: @escaping CompletionBlock<ListDetailResponce>) {
    if let response = responseListDetail {
      completion(.success(response))
    } else {
      let error = NSError(domain: "", code: 0, userInfo: nil)
      completion(.failure(.requestError(0, error.localizedDescription)))
    }
  }
  
  override func removeMovie(_ id: Int, param: RemoveMovieParam, completion: @escaping CompletionBlock<SuccessErrorModel>) {
    if let response = responseSuccessError {
      completion(.success(response))
    } else {
      let error = NSError(domain: "", code: 0, userInfo: nil)
      completion(.failure(.requestError(0, error.localizedDescription)))
    }
  }
  
  override func getFavoriteMovies(_ page: Int, completion: @escaping CompletionBlock<MovieResponce>) {
    if let response = responseMovie {
      completion(.success(response))
    } else {
      let error = NSError(domain: "", code: 0, userInfo: nil)
      completion(.failure(.requestError(0, error.localizedDescription)))
    }
  }
}
