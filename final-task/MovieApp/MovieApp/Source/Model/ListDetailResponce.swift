//
//  ListDetailResponce.swift
//  MovieApp
//
//  Created by rasul on 11/7/21.
//

import Foundation

struct ListDetailResponce: Codable, Equatable {
  let createdBy: String
  let description: String
  let favoriteCount: Int
  let id: String
  let items: [MovieModel]
  let itemCount: Int
  let iso6391: String
  let name: String
  let posterPath: String?

  private enum CodingKeys: String, CodingKey {
    case createdBy = "created_by"
    case description
    case favoriteCount = "favorite_count"
    case id
    case items
    case itemCount = "item_count"
    case iso6391 = "iso_639_1"
    case name
    case posterPath = "poster_path"
  }
}
