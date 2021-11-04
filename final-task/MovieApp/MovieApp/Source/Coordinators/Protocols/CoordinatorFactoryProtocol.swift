//
//  CoordinatorFactoryProtocol.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

import UIKit

protocol CoordinatorFactoryProtocol {
  func makeAppCoordinator(
    _ router: Router,
    screenFactory: ScreenFactoryProtocol) -> AppCoordinator
}
