//
//  MovieDetailModel.swift
//  MovieApp
//
//  Created by rasul on 11/10/21.
//

import Foundation

struct MovieDetailModel: Codable {
  let genres: [Genre]
  let homepage: String?
  let id: Int
  let imdbId, originalLanguage: String
  let originalTitle, overview: String
  let popularity: Double
  let posterPath: String?
  let releaseDate: String
  let budget: Int
  let revenue: Int
  let runtime: Int?
  let spokenLanguages: [SpokenLanguage]
  let status, title: String
  let voteAverage: Double
  
  public var backdropURL: URL? {
    guard let posterPath = posterPath else { return nil }
    return URL(string: "https://image.tmdb.org/t/p/original" + posterPath)
    
    
  }
}

struct Genre: Codable {
  let id: Int
  let name: String
}

struct SpokenLanguage: Codable {
  let iso6391, name: String
  
}
