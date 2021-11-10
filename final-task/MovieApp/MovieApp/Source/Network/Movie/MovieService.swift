//
//  MovieService.swift
//  MovieApp
//
//  Created by rasul on 11/10/21.
//

import Foundation

protocol MovieServiceProtocol {
  func getMovie(
    _ id: Int,
    _ completion: @escaping CompletionBlock<MovieDetailModel>)
  func getVideo(
    _ id: Int,
    completion: @escaping CompletionBlock<ResultsVideo>)
  func getMovieSimilar(
    _ id: Int,
    page: Int,
    completion: @escaping CompletionBlock<FavoriteMovieResponce>)
  func movieRate(
    _ id: Int,
    param: MovieRateParam,
    completion: @escaping CompletionBlock<SuccessErrorModel>)
}

final class MovieService: BaseAPI<MovieTargetType>, MovieServiceProtocol {
  func getMovie(_ id: Int, _ completion: @escaping CompletionBlock<MovieDetailModel>) {
    getData(target: .movie(id), completion: completion)
  }
  
  func getVideo(_ id: Int, completion: @escaping CompletionBlock<ResultsVideo>) {
    getData(target: .movieVideo(id), completion: completion)
  }
  
  func getMovieSimilar(_ id: Int, page: Int, completion: @escaping CompletionBlock<FavoriteMovieResponce>) {
    getData(target: .movieSimilar(id, page), completion: completion)
  }
  
  func movieRate(_ id: Int, param: MovieRateParam, completion: @escaping CompletionBlock<SuccessErrorModel>) {
    getData(target: .rateMovie(id, param), completion: completion)
  }
}
