//
//  AuthenticationToken.swift
//  MovieApp
//
//  Created by rasul on 10/31/21.
//

import Foundation

struct AuthenticationToken: Codable, Equatable {
  let success: Bool
  let expiresAt: String
  let requestToken: String
}

struct AuthenticationSession: Codable, Equatable {
  let success: Bool
  let sessionId: String?
}
