//
//  ScreenFactory.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

import Foundation

protocol ScreenFactory {
  func makeAuthScreen(_ coordinator: AuthCoordinatorProtocol) -> AuthViewController
}
