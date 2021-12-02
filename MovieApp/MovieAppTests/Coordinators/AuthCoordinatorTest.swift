//
//  AuthCoordinatorTest.swift
//  MovieAppTests
//
//  Created by rasul on 11/19/21.
//

import XCTest
@testable import MovieApp

class AuthCoordinatorTest: XCTestCase {

  private var authCoordinator: AuthCoordinatorProtocol!
  private var router: RouterMock!
  private var coordinatorFactory: CoordinatorFactoryMock!
  private var screenFactory: ScreenFactoryMock!
  private var tabBarController = TabBarController()
  
  override func setUp() {
    super.setUp()
    router = RouterMock()
    screenFactory = ScreenFactoryMock()
    coordinatorFactory = CoordinatorFactoryMock()
    authCoordinator = AuthCoordinator(router: router, coordinatorFactory: coordinatorFactory, screenFactory: screenFactory)
  }
}
