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
  let id: Int
  let originalTitle: String?
  let originalName: String?
  let overview: String
  let releaseDate: String?
  var posterPath: String?
  let popularity: Double
  let title: String?
  let voteAverage: Double

  private enum CodingKeys: String, CodingKey {
    case id
    case originalTitle = "original_title"
    case overview
    case releaseDate = "release_date"
    case posterPath = "poster_path"
    case popularity
    case title
    case voteAverage = "vote_average"
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

extension MovieModel {
   func createEntity(_ entity: MovieEntity) {
    entity.title = title
    entity.id = Int32(id)
    entity.originalTitle = originalTitle
    entity.overview = overview
    entity.releaseDate = releaseDate
    entity.posterPath = posterPath
    entity.originalName = originalName
    entity.popularity = popularity
    entity.voteAverage = voteAverage
   }
  
  static func getMovies(_ entities: [MovieEntity]) -> [MovieModel] {
    var items: [MovieModel] = []
    
    entities.forEach {
      let m = MovieModel(id: Int($0.id),
                         originalTitle: $0.originalTitle,
                         originalName: $0.originalName,
                         overview: $0.overview ?? "",
                         releaseDate: $0.releaseDate,
                         posterPath: $0.posterPath,
                         popularity: $0.popularity,
                         title: $0.title,
                         voteAverage: $0.voteAverage)
      items.append(m)
    }
    
    return items
  }
}
