//
//  Result+Extenstion.swift
//  MovieAppTests
//
//  Created by rasul on 11/1/21.
//

import Foundation

extension Result {
  var error: Failure? {
    switch self {
    case .failure(let error):
      return error
    default:
      return nil
    }
  }
  
  var value: Success? {
    switch self {
    case .success(let value):
      return value
    default:
      return nil
    }
  }
}
