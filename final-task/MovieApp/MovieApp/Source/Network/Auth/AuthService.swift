//
//  AuthAPI.swift
//  MovieApp
//
//  Created by rasul on 10/31/21.
//

import Foundation

/// @mockable
protocol AuthServiceProtocol {
  func newToken(
    _ completion: @escaping CompletionBlock<AuthenticationToken>)
  func sessionNew(
    _ param: RequestTokenParam,
    completion: @escaping CompletionBlock<AuthenticationSession>)
  func validateWithLogin(
    _ param: ValidationWithLoginParam,
    completion: @escaping CompletionBlock<AuthenticationToken>)
  func logout(
    _ param: SessionParam,
    completion: @escaping CompletionBlock<AuthenticationSession>)
}

final class AuthService: BaseAPI<AuthTargetType>, AuthServiceProtocol {
  func newToken(_ completion: @escaping CompletionBlock<AuthenticationToken>) {
    getData(target: .newToken, completion: completion)
  }
  
  func sessionNew(_ param: RequestTokenParam, completion: @escaping CompletionBlock<AuthenticationSession>) {
    getData(target: .sessionNew(param), completion: completion)
  }
  
  func validateWithLogin(_ param: ValidationWithLoginParam, completion: @escaping CompletionBlock<AuthenticationToken>) {
    getData(target: .validateWithLogin(param), completion: completion)
  }
  
  func logout(_ param: SessionParam, completion: @escaping CompletionBlock<AuthenticationSession>) {
    getData(target: .logout(param), completion: completion)
  }
}
