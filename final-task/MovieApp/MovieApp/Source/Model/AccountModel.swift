//
//  AccountModel.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//

import Foundation

struct AccountModel: Codable, Equatable {
  let avatar: Avatar
  let id: Int
  let name: String
  let includeAdult: Bool
  let username: String

  private enum CodingKeys: String, CodingKey {
    case avatar
    case id
    case name
    case includeAdult = "include_adult"
    case username
  }
}

struct Avatar: Codable, Equatable {
  let gravatar: Gravatar
}

struct Gravatar: Codable, Equatable {
  let hash: String
}
