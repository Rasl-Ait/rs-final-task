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

struct MovieModel: Codable, Equatable, Hashable {
  let adult: Bool?
  let backdropPath: String?
  let genreIds: [Int]
  let id: Int
  let originalTitle: String?
  let originalName: String?
  let overview: String
  let releaseDate: String?
  let posterPath: String?
  let popularity: Double
  let title: String?
  let video: Bool?
  let voteAverage: Double
  let voteCount: Int

  private enum CodingKeys: String, CodingKey {
    case adult
    case backdropPath = "backdrop_path"
    case genreIds = "genre_ids"
    case id
    case originalTitle = "original_title"
    case overview
    case releaseDate = "release_date"
    case posterPath = "poster_path"
    case popularity
    case title
    case video
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
    case originalName = "original_name"
  }
  
  public var backdropURL: String? {
      guard let posterPath = posterPath else { return nil }
      return "https://image.tmdb.org/t/p/original" + posterPath
  }
  
  public var iconString: String? {
      guard let posterPath = posterPath else { return nil }
      return "https://image.tmdb.org/t/p/w500" + posterPath
  }
}
