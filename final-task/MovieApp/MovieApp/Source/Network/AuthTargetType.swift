//
//  AuthTargetType.swift
//  MovieApp
//
//  Created by rasul on 10/31/21.
//

import Foundation

enum AuthTargetType {
  enum Constant {
    static let newToken = "authentication/token/new"
    static let sessionNew = "authentication/session/new"
    static let validateWithLogin = "authentication/token/validate_with_login"
    static let logout = "authentication/session"
  }
  
  case newToken
  case sessionNew(RequestTokenParam)
  case validateWithLogin(ValidationWithLoginParam)
  case logout(SessionParam)
}

extension AuthTargetType: TargetType {
  var path: String {
    switch self {
    case .newToken:
      return Constant.newToken
    case .sessionNew:
      return Constant.sessionNew
    case .validateWithLogin:
      return Constant.validateWithLogin
    case .logout:
      return Constant.logout
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .newToken:
      return .get
    case .sessionNew:
      return .post
    case .validateWithLogin:
      return .post
    case .logout:
      return .delete
    }
  }
  
  var task: Task {
    switch self {
    case .newToken:
      return .requestPlain
    case .sessionNew(let item):
      return .requestPostParameters(parameters: item)
    case .validateWithLogin(let item):
      return .requestPostParameters(parameters: item)
    case .logout(let item):
      return .requestPostParameters(parameters: item)
    }
  }
}
