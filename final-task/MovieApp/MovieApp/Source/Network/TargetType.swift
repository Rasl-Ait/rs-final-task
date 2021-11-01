//
//  TargetType.swift
//  MovieApp
//
//  Created by rasul on 10/31/21.
//

import Foundation

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
}

enum Task {
  case requestPlain
  case requestPostParameters(parameters: Encodable)
  case urlQueryParameters(parameters: [URLQueryItem])
}

protocol TargetType {
  var path: String { get }
  var method: HTTPMethod { get }
  var task: Task { get }
 // var headers: [String: String]? { get }
}
