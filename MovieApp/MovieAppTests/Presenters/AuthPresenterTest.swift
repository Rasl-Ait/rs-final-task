//
//  AuthPresenterTest.swift
//  MovieAppTests
//
//  Created by rasul on 11/19/21.
//

import XCTest
@testable import MovieApp

class AuthPresenterTest: XCTestCase {
  private var view: AuthViewInputMock!
  private var service: AuthServiceProtocolMock!
  private var presenter: AuthPresenter!
  
  override func setUp() {
     view = AuthViewInputMock()
     service = AuthServiceProtocolMock()
     presenter = AuthPresenter(service: service, view: view)
  }
  
  func test_newTokenSuccess() {
    let token = AuthenticationToken(success: true, expiresAt: "2016-08-26 17:04:39 UTC", requestToken: "ff5c7eeb5a8870efe3cd7fc5c282cffd26800ecd")
    let param = AuthParam(username: "lol", password: "kek")
    
    service.newTokenHandler = { completion in
      completion(.success(token))
    }
    
    service.newToken { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        XCTAssertEqual(item.success, token.success)
        XCTAssertEqual(item.expiresAt, token.expiresAt)
        XCTAssertEqual(item.requestToken, token.requestToken)
        self.view.success()
      case .failure(let error):
        self.view.failure(error: error)
      }
    }
    
      presenter.newToken(param)
    
    XCTAssertEqual(view.successCallCount, 1)
    XCTAssertEqual(view.failureCallCount, 0)
    XCTAssertEqual(service.newTokenCallCount, 2)
  }
  
  func test_newTokenFailure() {
    let token = AuthenticationToken(success: true, expiresAt: "2016-08-26 17:04:39 UTC", requestToken: "ff5c7eeb5a8870efe3cd7fc5c282cffd26800ecd")
    let param = AuthParam(username: "lol", password: "kek")
    
    service.newTokenHandler = { completion in
      completion(.failure(.requestError(1, "fauilure")))
    }
    
    service.newToken { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        XCTAssertEqual(item.success, token.success)
        XCTAssertEqual(item.expiresAt, token.expiresAt)
        XCTAssertEqual(item.requestToken, token.requestToken)
        self.view.success()
      case .failure(let error):
        self.view.failure(error: error)
      }
    }
    
    presenter.newToken(param)
    
    XCTAssertEqual(view.successCallCount, 0)
    XCTAssertEqual(view.failureCallCount, 1)
    XCTAssertEqual(service.newTokenCallCount, 2)
  }
  
  func test_validationSuccess() {
    let token = AuthenticationToken(success: true, expiresAt: "2016-08-26 17:04:39 UTC", requestToken: "ff5c7eeb5a8870efe3cd7fc5c282cffd26800ecd")
    let param = ValidationWithLoginParam(username: "lol", password: "ken", token: token.requestToken)
    let session = AuthenticationSession(success: true, sessionId: UserDefaults.standard.sessionID)
    let requestTokenParam = RequestTokenParam(token: token.requestToken)

    service.validateWithLoginHandler = { _, completion in
      completion(.success(token))
    }
    
    service.sessionNewHandler = { _, completion in
      completion(.success(session))

    }

    self.service.sessionNew(requestTokenParam) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        XCTAssertEqual(item.success, session.success)
        XCTAssertEqual(item.sessionId, session.sessionId)
        self.view.success()
      case .failure(let error):
        self.view.failure(error: error)
      }
    }
    
    service.validateWithLogin(param) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        XCTAssertEqual(item.success, token.success)
        XCTAssertEqual(item.expiresAt, token.expiresAt)
        XCTAssertEqual(item.requestToken, token.requestToken)
        self.presenter.sessionNew(item.requestToken)
      case .failure(let error):
        self.view.failure(error: error)
      }
    }

    presenter.validationLogin(param)

    XCTAssertEqual(view.successCallCount, 1)
    XCTAssertEqual(view.failureCallCount, 0)
    XCTAssertEqual(service.sessionNewCallCount, 3)
    XCTAssertEqual(service.validateWithLoginCallCount, 2)
  }
  
  func test_validationFailure() {
    let token = AuthenticationToken(success: true, expiresAt: "2016-08-26 17:04:39 UTC", requestToken: "ff5c7eeb5a8870efe3cd7fc5c282cffd26800ecd")
    let param = ValidationWithLoginParam(username: "lol", password: "ken", token: token.requestToken)
    let requestTokenParam = RequestTokenParam(token: token.requestToken)

    service.validateWithLoginHandler = { _, completion in
      completion(.failure(.requestError(1, "failure")))
    }
    
    service.sessionNewHandler = { _, completion in
      completion(.failure(.requestError(1, "failure")))

    }

    self.service.sessionNew(requestTokenParam) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success:
        self.view.success()
      case .failure(let error):
        self.view.failure(error: error)
      }
    }
    
    service.validateWithLogin(param) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        XCTAssertEqual(item.success, token.success)
        XCTAssertEqual(item.expiresAt, token.expiresAt)
        XCTAssertEqual(item.requestToken, token.requestToken)
        self.presenter.sessionNew(item.requestToken)
      case .failure(let error):
        self.view.failure(error: error)
      }
    }

    presenter.validationLogin(param)

    XCTAssertEqual(view.successCallCount, 0)
    XCTAssertEqual(view.failureCallCount, 2)
    XCTAssertEqual(service.sessionNewCallCount, 1)
    XCTAssertEqual(service.validateWithLoginCallCount, 2)
  }
}
