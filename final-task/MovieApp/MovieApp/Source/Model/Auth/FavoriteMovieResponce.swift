//
//  FavoriteMovieResponce.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//

import Foundation

struct FavoriteMovieResponce: Codable, Equatable {
  let page: Int
  let results: [MovieModel]
  let totalPages: Int
  let totalResults: Int

  private enum CodingKeys: String, CodingKey {
    case page
    case results
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}
