//
//  AuthParams.swift
//  MovieApp
//
//  Created by rasul on 11/1/21.
//

import Foundation

struct RequestTokenParam: Encodable {
  let token: String
  
  enum CodingKeys: String, CodingKey {
    case token = "request_token"
  }
}

struct SessionParam: Encodable {
  let id: String
  
  enum CodingKeys: String, CodingKey {
    case id = "session_id"
  }
}

struct ValidationWithLoginParam: Encodable {
  let username: String
  let password: String
  let token: String
  
  enum CodingKeys: String, CodingKey {
    case token = "request_token"
    case password
    case username
  }
}
