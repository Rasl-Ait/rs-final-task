//
//  AccountParam.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//

import Foundation

struct ListFavoriteParam: Encodable {
  let mediaType: String
  let mediaID: Int
  let favorite: Bool

  private enum CodingKeys: String, CodingKey {
    case mediaType = "media_type"
    case mediaID = "media_id"
    case favorite
  }
}

struct NewListParam: Encodable {
  let name: String
  let description = ""
}

struct RemoveMovieParam: Encodable {
  let mediaID: Int
  
  private enum CodingKeys: String, CodingKey {
    case mediaID = "media_id"
  }
}
