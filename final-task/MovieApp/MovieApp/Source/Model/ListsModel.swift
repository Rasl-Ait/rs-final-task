//
//  ListsModel.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//

import Foundation

struct ListResponce: Codable, Equatable {
  let page: Int
  let results: [ListModel]
  let totalPages: Int
  let totalResults: Int

  private enum CodingKeys: String, CodingKey {
    case page
    case results
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}

struct ListModel: Codable, Equatable {
  let description: String
  let favoriteCount: Int
  let id: Int
  let itemCount: Int
  let listType: String
  let name: String
  let posterPath: String?

  private enum CodingKeys: String, CodingKey {
    case description
    case favoriteCount = "favorite_count"
    case id
    case itemCount = "item_count"
    case listType = "list_type"
    case name
    case posterPath = "poster_path"
  }
}
