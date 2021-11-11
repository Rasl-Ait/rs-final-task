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
}

struct Avatar: Codable, Equatable {
  let gravatar: Gravatar
}

struct Gravatar: Codable, Equatable {
  let hash: String
}
