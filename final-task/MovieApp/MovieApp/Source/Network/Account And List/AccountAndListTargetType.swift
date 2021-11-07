//
//  AccountListTargetType.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//

import Foundation

enum AccountAndListTargetType {
  enum Constant {
    static let account = "account"
  }
  
  case account
  case lists(Int, Int)
  case markFavorite(Int, ListFavoriteParam)
  case movieFavorite(Int, Int)
  case list(NewListParam)
  case listDelete(Int)
  case listDetail(Int)
}

extension AccountAndListTargetType: TargetType {
  var path: String {
    switch self {
    case .account:
      return Constant.account
    case .lists(let id, _):
      return "account/\(id)/lists"
    case .markFavorite(let id, _):
      return "account/\(id)/favorite"
    case .movieFavorite(let id, _):
      return "account/\(id)/favorite/movies"
    case .list:
      return "list"
    case .listDelete(let id):
      return "list/\(id)"
    case .listDetail(let id):
      return "list/\(id)"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .account, .lists, .movieFavorite, .listDetail:
      return .get
    case .markFavorite, .list:
      return .post
    case .listDelete:
      return .delete
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
      let param = [
        URLQueryItem(name: "session_id", value: UserDefaults.standard.sessionID)
      ]
      return .postAndGetParameters(parameters: item, query: param)
    case .list(let item):
      let param = [
        URLQueryItem(name: "session_id", value: UserDefaults.standard.sessionID)
      ]
      return .postAndGetParameters(parameters: item, query: param)
    case .listDelete:
      let param = [
        URLQueryItem(name: "session_id", value: UserDefaults.standard.sessionID)
      ]
      return .urlQueryParameters(parameters: param)
    case .listDetail:
      return .requestPlain
    }
  }
}
