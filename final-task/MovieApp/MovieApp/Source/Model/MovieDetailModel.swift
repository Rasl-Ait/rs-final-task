//
//  MovieDetailModel.swift
//  MovieApp
//
//  Created by rasul on 11/10/21.
//

import Foundation

struct MovieDetailModel: Codable, Equatable {
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

struct Genre: Codable, Equatable {
  let id: Int
  let name: String
}

struct SpokenLanguage: Codable, Equatable {
  let iso6391, name: String
  
}

struct MovieVideo: Codable, Equatable {
    let name: String
    let key: String
    
    var videoURL: URL? {
        return URL(string: "http://img.youtube.com/vi/\(key)/0.jpg")
    }
}

struct ResultsVideo: Codable, Equatable {
    var results: [MovieVideo]
}
