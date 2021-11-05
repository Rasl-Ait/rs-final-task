//
//  CoordinatorFactoryProtocol.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

import UIKit

protocol CoordinatorFactory {
  func makeAppCoordinator(
    _ router: Router,
    screenFactory: ScreenFactory) -> AppCoordinator
  
  func makeAuthCoordinator(
    _ router: Router,
    screenFactory: ScreenFactory) -> AuthCoordinator
}
