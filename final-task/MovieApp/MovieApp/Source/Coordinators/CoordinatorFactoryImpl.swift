//
//  CoordinatorFactoryImpl.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

import UIKit

final class CoordinatorFactoryImpl: CoordinatorFactory {
  func makeAppCoordinator(
    _ router: Router,
    screenFactory: ScreenFactory) -> AppCoordinator {
    AppCoordinator(router: router, screenFactory: screenFactory, coordinatorFactory: self)
  }
  
  func makeAuthCoordinator(
    _ router: Router,
    screenFactory: ScreenFactory) -> AuthCoordinator {
  AuthCoordinator(router: router, screenFactory: screenFactory)
  }
}
