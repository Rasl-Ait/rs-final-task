//
//  MovieResponce.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//

import Foundation

struct MovieResponce: Codable, Equatable {
  let page: Int
  let results: [MovieModel]
  let totalPages: Int
  let totalResults: Int
}
