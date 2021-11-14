//
//  AccountService.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//

import Foundation

protocol AccountAndListServiceProtocol {
  func getAccount(
    _ completion: @escaping CompletionBlock<AccountModel>)
  func getLists(
    _ page: Int,
    completion: @escaping CompletionBlock<ListResponce>)
  func getFavoriteMovies(
    _ page: Int,
    completion: @escaping CompletionBlock<MovieResponce>)
  func markAsFavorite(
    _ param: ListFavoriteParam,
    completion: @escaping CompletionBlock<SuccessErrorModel>)
  func createList(
    _ param: NewListParam,
    completion: @escaping CompletionBlock<NewListResponce>)
  func deleteList(
    _ id: Int,
    completion: @escaping CompletionBlock<SuccessErrorModel>)
  func listDetail(
    _ id: Int,
    completion: @escaping CompletionBlock<ListDetailResponce>)
  func movieToList(
    _ id: Int,
    param: MovieToListParam,
    completion: @escaping CompletionBlock<SuccessErrorModel>)
  func removeMovie(
    _ id: Int,
    param: RemoveMovieParam,
    completion: @escaping CompletionBlock<SuccessErrorModel>)
  
}

final class AccountAndListService: BaseAPI<AccountAndListTargetType>, AccountAndListServiceProtocol {
  func getAccount(_ completion: @escaping CompletionBlock<AccountModel>) {
    getData(target: .account, completion: completion)
  }
  
  func getLists(_ page: Int, completion: @escaping CompletionBlock<ListResponce>) {
    getData(target: .lists(UserDefaults.standard.accountID, page), completion: completion)
  }
  
  func getFavoriteMovies(_ page: Int, completion: @escaping CompletionBlock<MovieResponce>) {
    getData(target: .movieFavorite(UserDefaults.standard.accountID, page), completion: completion)
  }
  
  func markAsFavorite(_ param: ListFavoriteParam, completion: @escaping CompletionBlock<SuccessErrorModel>) {
    getData(target: .markFavorite(UserDefaults.standard.accountID, param), completion: completion)
  }
  
  func createList(_ param: NewListParam, completion: @escaping CompletionBlock<NewListResponce>) {
    getData(target: .list(param), completion: completion)
  }
  
  func deleteList(_ id: Int, completion: @escaping CompletionBlock<SuccessErrorModel>) {
    getData(target: .listDelete(id), completion: completion)
  }
  
  func listDetail(_ id: Int, completion: @escaping CompletionBlock<ListDetailResponce>) {
    getData(target: .listDetail(id), completion: completion)
  }
  
  func removeMovie(_ id: Int, param: RemoveMovieParam, completion: @escaping CompletionBlock<SuccessErrorModel>) {
    getData(target: .removeMovie(id, param), completion: completion)
  }
  
  func movieToList(_ id: Int, param: MovieToListParam, completion: @escaping CompletionBlock<SuccessErrorModel>) {
    getData(target: .movieToList(id, param), completion: completion)
  }
}
