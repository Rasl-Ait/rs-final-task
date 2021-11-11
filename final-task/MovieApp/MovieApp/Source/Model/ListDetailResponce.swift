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
}
