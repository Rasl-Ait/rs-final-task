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

  private enum CodingKeys: String, CodingKey {
    case success
    case expiresAt = "expires_at"
    case requestToken = "request_token"
  }
}

struct AuthenticationSession: Codable, Equatable  {
  let success: Bool
  let sessionId: String?

  private enum CodingKeys: String, CodingKey {
    case success
    case sessionId = "session_id"
  }
}
