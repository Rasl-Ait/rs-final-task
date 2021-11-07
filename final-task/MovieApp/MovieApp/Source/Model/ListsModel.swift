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

struct ListModel: Codable, Equatable, Hashable {
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
  
  func createEntity(_ model: ListEntity) {
    model.id = Int32(id)
    model.favoriteCount = Int16(favoriteCount)
    model.itemCount = Int16(itemCount)
    model.listType = listType
    model.name = name
    model.descr = description
  }
}

extension ListModel {
  static func getEntities(entity: ListEntity) -> ListModel {
    return ListModel(description: entity.descr ?? "",
                     favoriteCount: Int(entity.favoriteCount),
                     id: Int(entity.id),
                     itemCount: Int(entity.itemCount),
                     listType: entity.listType ?? "",
                     name: entity.name ?? "",
                     posterPath: nil)
    
  }
}

struct NewListResponce: Codable, Equatable {
  let statusMessage: String
  let success: Bool
  let statusCode: Int
  let listID: Int

  private enum CodingKeys: String, CodingKey {
    case statusMessage = "status_message"
    case success
    case statusCode = "status_code"
    case listID = "list_id"
  }
}
