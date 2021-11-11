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
  let originalLanguage: String
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
  let video: Bool
  
  public var backdropString: String? {
    guard let posterPath = posterPath else { return nil }
    return "https://image.tmdb.org/t/p/original" + posterPath
  }
  
  var score: Double {
      return voteAverage * 10
  }
  
  var genresString: String {
      return genres.map { $0.name }.joined(separator: ", ")
  }
  
  var languagesString: String {
      return spokenLanguages.map { $0.name }.joined(separator: ", ")
  }
  
  var shortFormatDuration: String {
      let timeFormatter = DateComponentsFormatter()
      timeFormatter.unitsStyle = .short
      
      guard let duration = runtime else { return "0 s" }
      var time = duration * 60
      if time > 3600 {
          time -= time % 60
      }
      
      return timeFormatter.string(from: Double(time)) ?? "0 s"
  }
}

struct Genre: Codable, Equatable {
  let id: Int
  let name: String
}

struct SpokenLanguage: Codable, Equatable {
  let iso6391, name: String
  
}

struct MovieVideo: Codable, Equatable, Hashable {
    let name: String
    let key: String
    
    var videoURL: URL? {
        return URL(string: "http://img.youtube.com/vi/\(key)/0.jpg")
    }
}

struct ResultsVideo: Codable, Equatable {
    var results: [MovieVideo]
}

struct MovieStates: Codable, Equatable {
  let id: Int
  let favorite: Bool
  let rated: Bool
  let watchlist: Bool
}
