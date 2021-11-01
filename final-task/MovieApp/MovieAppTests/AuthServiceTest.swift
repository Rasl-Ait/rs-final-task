//
//  NetworkServiceTest.swift
//  MovieAppTests
//
//  Created by rasul on 10/31/21.
//

import XCTest
@testable import MovieApp

class MockHTTPClient: HTTPClient {
  var inputRequest: URLRequest?
  var executeCalled = false
  var result: Result<Data, APIError>?
  
  func request(request: URLRequest, completion: @escaping (Result<Data, APIError>) -> Void) {
    executeCalled = true
    inputRequest = request
    result.map(completion)
  }
}

class AuthServiceTest: XCTestCase {
  
  func test_NewTokenRequest() {
    let sut = makeSUT()
    sut.service.newToken { _ in }
    XCTAssertTrue(sut.client.executeCalled)
    XCTAssertEqual(sut.client.inputRequest, .queryParams(AuthTargetType.Constant.newToken, param: ([], nil)))
  }
  
  func test_SessionNewWithParamRequest() {
    let sut = makeSUT()
    let param = RequestTokenParam(token: "82cffd26800ecd")
    
    sut.service.sessionNew(param) { _ in }
    XCTAssertTrue(sut.client.executeCalled)
    let request: URLRequest = .queryParams(AuthTargetType.Constant.sessionNew,
                                           param: ([], param),
                                           httpMethod: .post)
    XCTAssertEqual(sut.client.inputRequest, request)
  }
  
  func test_ValidateWithLoginParamRequest() {
    let sut = makeSUT()
    let param = ValidationWithLoginParam(username: "Shapai", password: "123", token: "82cffd26800ecd")
    
    sut.service.validateWithLogin(param) { _ in }
    XCTAssertTrue(sut.client.executeCalled)
    let request: URLRequest = .queryParams(AuthTargetType.Constant.validateWithLogin,
                                           param: ([], param),
                                           httpMethod: .post)
    XCTAssertEqual(sut.client.inputRequest, request)
  }
  
  func test_LogoutRequest() {
    let sut = makeSUT()
    let param = SessionParam(id: "282cffd26800ecd")
    
    sut.service.logout(param) { _ in }
    XCTAssertTrue(sut.client.executeCalled)
    let request: URLRequest = .queryParams(AuthTargetType.Constant.logout,
                                           param: ([], param),
                                           httpMethod: .delete)
    XCTAssertEqual(sut.client.inputRequest, request)
  }
  
  func testNewTokenWithSuccessResponse() throws {
    let expectedNewToken = AuthenticationToken(
      success: true,
      expiresAt: "2016-08-26 17:04:39 UTC",
      requestToken: "ff5c7eeb5a8870efe3cd7fc5c282cffd26800ecd")
    let response = try JSONEncoder().encode(expectedNewToken)
    
    let sut = makeSUT()
    sut.client.result = .success(response)
    
    var result: Result<AuthenticationToken, APIError>?
    
    sut.service.newToken { result = $0 }
    
    XCTAssertEqual(result?.value, expectedNewToken)
  }
  
  func test_SessionNewWithSuccessResponse() throws {
    let expectedSessionID = AuthenticationSession(success: true, sessionId: "82cffd26")
    let response = try JSONEncoder().encode(expectedSessionID)
    
    let param = RequestTokenParam(token: "82cffd26800ecd")
    
    let sut = makeSUT()
    sut.client.result = .success(response)
    
    var result: Result<AuthenticationSession, APIError>?
    
    sut.service.sessionNew(param) { result = $0 }
    XCTAssertEqual(result?.value, expectedSessionID)
  }
  
  func test_ValidateWithLoginSuccessResponse() throws {
    let expectedValidate = AuthenticationToken(
      success: true,
      expiresAt: "2016-08-26 17:04:39 UTC",
      requestToken: "ff5c7eeb5a8870efe3cd7fc5c282cffd26800ecd")
    let response = try JSONEncoder().encode(expectedValidate)
    
    let param = ValidationWithLoginParam(username: "Shapai", password: "123", token: "82cffd26800ecd")
    
    let sut = makeSUT()
    sut.client.result = .success(response)
    
    var result: Result<AuthenticationToken, APIError>?
    
    sut.service.validateWithLogin(param) { result = $0 }
    XCTAssertEqual(result?.value, expectedValidate)
  }
  
  func test_LogoutSuccessResponse() throws {
    let expectedSessionID = AuthenticationSession(success: true, sessionId: "82cffd26")
    let response = try JSONEncoder().encode(expectedSessionID)
    
    let param = SessionParam(id: "282cffd26800ecd")
    
    let sut = makeSUT()
    sut.client.result = .success(response)
    
    var result: Result<AuthenticationSession, APIError>?
    
    sut.service.logout(param) { result = $0 }
    XCTAssertEqual(result?.value, expectedSessionID)
  }
  
  private func makeSUT() -> (service: AuthService, client: MockHTTPClient) {
    let httpClient = MockHTTPClient()
    let sut = AuthService(client: httpClient)
    return (sut, httpClient)
  }
}
