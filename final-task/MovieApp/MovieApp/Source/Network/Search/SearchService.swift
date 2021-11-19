//
//  SearchService.swift
//  MovieApp
//
//  Created by rasul on 11/12/21.
//

import Foundation

/// @mockable
protocol SearchServiceProtocol {
  func search(
    _ param: SearchParam ,
    _ completion: @escaping CompletionBlock<MovieResponce>)
}

final class SearchService: BaseAPI<SearchTargetType>, SearchServiceProtocol {
  func search(_ param: SearchParam, _ completion: @escaping CompletionBlock<MovieResponce>) {
    getData(target: .search(param), completion: completion)
  }
}
