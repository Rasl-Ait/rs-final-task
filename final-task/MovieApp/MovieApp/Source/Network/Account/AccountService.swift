//
//  AccountService.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//

import Foundation

protocol AccountServiceProtocol {
  func getAccount(
    _ completion: @escaping CompletionBlock<AccountModel>)
  func getLists(
    _ page: Int,
    completion: @escaping CompletionBlock<ListResponce>)
  func getFavoriteMovies(
    _ page: Int,
    completion: @escaping CompletionBlock<FavoriteMovieResponce>)
  func markAsFavorite(
    _ param: ListFavoriteParam,
    completion: @escaping CompletionBlock<ErrorModel>)
}

class AccountService: BaseAPI<AccountTargetType>, AccountServiceProtocol {
  func getAccount(_ completion: @escaping CompletionBlock<AccountModel>) {
    getData(target: .account, completion: completion)
  }
  
  func getLists(_ page: Int, completion: @escaping CompletionBlock<ListResponce>) {
    getData(target: .lists(UserDefaults.standard.accountID, page), completion: completion)
  }
  
  func getFavoriteMovies(_ page: Int, completion: @escaping CompletionBlock<FavoriteMovieResponce>) {
    getData(target: .movieFavorite(UserDefaults.standard.accountID, page), completion: completion)
  }
  
  func markAsFavorite(_ param: ListFavoriteParam, completion: @escaping CompletionBlock<ErrorModel>) {
    getData(target: .markFavorite(UserDefaults.standard.accountID, param), completion: completion)
  }
}
