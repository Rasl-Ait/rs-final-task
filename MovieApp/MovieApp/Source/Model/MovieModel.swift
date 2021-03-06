//
//  MovieModel.swift
//  MovieApp
//
//  Created by rasul on 11/10/21.
//

import Foundation

struct MovieModel: Codable, Equatable {
  let id: Int
  let originalTitle: String?
  let originalName: String?
  let overview: String
  let releaseDate: String?
  var posterPath: String?
  let popularity: Double
  let title: String?
  let voteAverage: Double
  
  public var backdropURL: String? {
      guard let posterPath = posterPath else { return nil }
      return "https://image.tmdb.org/t/p/original" + posterPath
  }
  
  public var iconString: String? {
      guard let posterPath = posterPath else { return nil }
      return "https://image.tmdb.org/t/p/w500" + posterPath
  }
}

extension MovieModel: Hashable {
  static func == (lhs: MovieModel, rhs: MovieModel) -> Bool {
         return lhs.id == rhs.id
     }

     func hash(into hasher: inout Hasher) {
         hasher.combine(id)
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
  
  func createEntity(_ entity: FavoriteMovieEntity) {
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
  
  static func getMovie(entity: MovieEntity) -> MovieModel {
    return MovieModel(id: Int(entity.id),
                      originalTitle: entity.originalTitle,
                      originalName: entity.originalName,
                      overview: entity.overview ?? "",
                      releaseDate: entity.releaseDate,
                      posterPath: entity.posterPath,
                      popularity: entity.popularity,
                      title: entity.title,
                      voteAverage: entity.voteAverage)
  }
  
  static func getFavoriteMovie(entity: FavoriteMovieEntity) -> MovieModel {
    return MovieModel(id: Int(entity.id),
                      originalTitle: entity.originalTitle,
                      originalName: entity.originalName,
                      overview: entity.overview ?? "",
                      releaseDate: entity.releaseDate,
                      posterPath: entity.posterPath,
                      popularity: entity.popularity,
                      title: entity.title,
                      voteAverage: entity.voteAverage)
  }
  
}
