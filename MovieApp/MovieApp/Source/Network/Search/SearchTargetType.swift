//
//  SearchTargetType.swift
//  MovieApp
//
//  Created by rasul on 11/12/21.
//

import Foundation

enum SearchTargetType {
  enum Constant {
    static let sessionID = UserDefaults.standard.sessionID
  }
  
  case search(SearchParam)
}

extension SearchTargetType: TargetType {
  var path: String {
    switch self {
    case .search:
      return "search/movie"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .search:
      return .get
    }
  }
  
  var task: Task {
    switch self {
    case .search( let param):
      return .urlQueryParameters(parameters: param.getParam(param: param))
    }
  }
}
