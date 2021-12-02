//
//  ErrorModel.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//

import Foundation

struct SuccessErrorModel: Codable, Equatable {
  let statusCode: Int
  let statusMessage: String
}
