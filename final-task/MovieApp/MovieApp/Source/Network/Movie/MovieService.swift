//
//  MovieService.swift
//  MovieApp
//
//  Created by rasul on 11/10/21.
//

import Foundation

protocol MovieServiceProtocol {
  
  /// Get the primary information about a movie.
  func getMovie(
    _ id: Int,
    _ completion: @escaping CompletionBlock<MovieDetailModel>)
  
  /// Get the videos that have been added to a movie.
  func getVideo(
    _ id: Int,
    completion: @escaping CompletionBlock<ResultsVideo>)
  
  /// Get a list of similar movies
  func getMovieSimilar(
    _ id: Int,
    page: Int,
    completion: @escaping CompletionBlock<MovieResponce>)
  
  /// Rate a movie.
  func movieRate(
    _ id: Int,
    param: MovieRateParam,
    completion: @escaping CompletionBlock<SuccessErrorModel>)
  
  /// Grab the following account states for a session
  func getAccountStates(
    _ id: Int,
    completion: @escaping CompletionBlock<MovieStates>)
}

final class MovieService: BaseAPI<MovieTargetType>, MovieServiceProtocol {
  func getMovie(_ id: Int, _ completion: @escaping CompletionBlock<MovieDetailModel>) {
    getData(target: .movie(id), completion: completion)
  }
  
  func getVideo(_ id: Int, completion: @escaping CompletionBlock<ResultsVideo>) {
    getData(target: .movieVideo(id), completion: completion)
  }
  
  func getMovieSimilar(_ id: Int, page: Int, completion: @escaping CompletionBlock<MovieResponce>) {
    getData(target: .movieSimilar(id, page), completion: completion)
  }
  
  func movieRate(_ id: Int, param: MovieRateParam, completion: @escaping CompletionBlock<SuccessErrorModel>) {
    getData(target: .rateMovie(id, param), completion: completion)
  }
  
  func getAccountStates(_ id: Int, completion: @escaping CompletionBlock<MovieStates>) {
    getData(target: .accountStates(id), completion: completion)
  }
}
