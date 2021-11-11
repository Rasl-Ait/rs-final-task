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
}

struct ListModel: Codable, Equatable, Hashable {
  let description: String
  let favoriteCount: Int
  let id: Int
  let itemCount: Int
  let listType: String
  let name: String
  let posterPath: String?
  var movies: [MovieModel]?
  
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
    let movies = MovieModel.getMovies(entity.movies?.toArray() ?? [])
    return ListModel(description: entity.descr ?? "",
                     favoriteCount: Int(entity.favoriteCount),
                     id: Int(entity.id),
                     itemCount: Int(entity.itemCount),
                     listType: entity.listType ?? "",
                     name: entity.name ?? "",
                     posterPath: nil,
                     movies: movies)
    
  }
}

struct NewListResponce: Codable, Equatable {
  let statusMessage: String
  let success: Bool
  let statusCode: Int
  let listID: Int
}
