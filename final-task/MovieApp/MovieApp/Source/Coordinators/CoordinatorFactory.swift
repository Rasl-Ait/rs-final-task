//
//  CoordinatorFactory.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

import UIKit

final class CoordinatorFactory: CoordinatorFactoryProtocol {
  func makeAppCoordinator(_ router: Router, screenFactory: ScreenFactoryProtocol) -> AppCoordinator {
    AppCoordinator(router: router, screenFactory: screenFactory)
  }
}
