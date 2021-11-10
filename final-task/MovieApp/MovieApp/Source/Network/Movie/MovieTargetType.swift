//
//  MovieTargetType.swift
//  MovieApp
//
//  Created by rasul on 11/10/21.
//

import Foundation



enum MovieTargetType {
  enum Constant {
    static let sessionID = UserDefaults.standard.sessionID
  }
  
  case movie(Int)
  case movieVideo(Int)
  case movieSimilar(Int, Int)
  case rateMovie(Int, MovieRateParam)
}

extension MovieTargetType: TargetType {
  var path: String {
    switch self {
    case .movie(let id):
      return "movie/\(id)"
    case .movieVideo(let id):
      return "movie/\(id)/videos"
    case .movieSimilar(let id, _):
      return "movie/\(id)/similar"
    case .rateMovie(let id, _):
      return "movie/\(id)/rating"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .movie:
      return .get
    case .movieVideo:
      return .get
    case .movieSimilar:
      return .get
    case .rateMovie:
      return .post
    }
  }
  
  var task: Task {
    switch self {
    case .movie:
      return .requestPlain
    case .movieVideo:
      return .requestPlain
    case .movieSimilar(_, let page):
      let param = [
        URLQueryItem(name: "page", value: page.toString)
      ]
      return .urlQueryParameters(parameters: param)
    case .rateMovie(_, let item):
      let param = [
        URLQueryItem(name: "session_id", value: Constant.sessionID)
      ]
      return .postAndGetParameters(parameters: item, query: param)
    }
  }
}
