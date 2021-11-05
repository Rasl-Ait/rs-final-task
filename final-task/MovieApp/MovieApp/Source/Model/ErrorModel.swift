//
//  ErrorModel.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//

import Foundation

struct ErrorModel: Codable, Equatable {
  let statusCode: Int
  let statusMessage: String

  private enum CodingKeys: String, CodingKey {
    case statusCode = "status_code"
    case statusMessage = "status_message"
  }
}
