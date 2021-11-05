//
//  AccountTargetType.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//

import Foundation

enum AccountTargetType {
  enum Constant {
    static let account = "account"
  }
  
  case account
  case lists(Int, Int)
  case markFavorite(Int, ListFavoriteParam)
  case movieFavorite(Int, Int)

}

extension AccountTargetType: TargetType {
  var path: String {
    switch self {
    case .account:
      return Constant.account
    case .lists(let id, _):
      return "account/\(id)/lists"
    case .markFavorite(let id, _):
      return "account/\(id)/favorite?session_id=1beaf79c606e6c534c2280f4104d91bec9abfbd8"
    case .movieFavorite(let id, _):
      return "account/\(id)/favorite/movies"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .account, .lists, .movieFavorite:
      return .get
    case .markFavorite:
      return .post
    }
  }
  
  var task: Task {
    switch self {
    case .account:
      let param = [URLQueryItem(name: "session_id", value: UserDefaults.standard.sessionID)]
      return .urlQueryParameters(parameters: param)
    case .lists(_, let page):
      let param = [
        URLQueryItem(name: "page", value: page.toString),
        URLQueryItem(name: "session_id", value: UserDefaults.standard.sessionID)
      ]
      return .urlQueryParameters(parameters: param)
    case .movieFavorite(_, let page):
      let param = [
        URLQueryItem(name: "page", value: page.toString),
        URLQueryItem(name: "session_id", value: UserDefaults.standard.sessionID)
      ]
      return .urlQueryParameters(parameters: param)
    case .markFavorite(_, let item):
      return .requestPostParameters(parameters: item)
    }
  }
}
