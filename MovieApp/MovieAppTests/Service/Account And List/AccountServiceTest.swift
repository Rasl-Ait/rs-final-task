//
//  AccountServiceTest.swift
//  MovieAppTests
//
//  Created by rasul on 11/5/21.
//

import XCTest
@testable import MovieApp

class AccountServiceTest: XCTestCase {
  
  let accountID = UserDefaults.standard.accountID
  let sessionID = UserDefaults.standard.sessionID
  
  func test_getAccountRequest() {
    let sut = makeSUT()
    
    let param = [
      URLQueryItem(name: "session_id", value: sessionID)
    ]
    
    sut.service.getAccount { _ in }
    XCTAssertTrue(sut.client.executeCalled)
    XCTAssertEqual(sut.client.inputRequest, .queryParams("account", param: (param, nil)))
  }
  
  func test_getListsRequest() {
    let sut = makeSUT()
    let param = [
      URLQueryItem(name: "page", value: 1.toString),
      URLQueryItem(name: "session_id", value: sessionID)
    ]
    
    sut.service.getLists(1) { _ in }
    XCTAssertTrue(sut.client.executeCalled)
    let request: URLRequest = .queryParams("account/\(accountID)/lists",
                                           param: (param, nil),
                                           httpMethod: .get)
    XCTAssertEqual(sut.client.inputRequest, request)
  }
  
  func test_getFavoriteMovieRequest() {
    let sut = makeSUT()
    let param = [
      URLQueryItem(name: "page", value: 1.toString),
      URLQueryItem(name: "session_id", value: sessionID)
    ]
    sut.service.getFavoriteMovies(1) { _ in }
    XCTAssertTrue(sut.client.executeCalled)
    let request: URLRequest = .queryParams("account/\(accountID)/favorite/movies",
                                           param: (param, nil),
                                           httpMethod: .get)
    XCTAssertEqual(sut.client.inputRequest, request)
  }

  func test_markAsFavoriteRequest() {
    let sut = makeSUT()
    let param = ListFavoriteParam(mediaType: "movie", mediaID: 550, favorite: true)

    let query = [
      URLQueryItem(name: "session_id", value: sessionID)
    ]
    
    sut.service.markAsFavorite(param) { _ in }
    XCTAssertTrue(sut.client.executeCalled)
    let request: URLRequest = .queryParams("account/\(accountID)/favorite",
                                           param: (query, param),
                                           httpMethod: .post)
    XCTAssertEqual(sut.client.inputRequest, request)
  }
  
  func test_createListRequest() {
    let sut = makeSUT()
    let param = NewListParam(name: "New List")

    let query = [
      URLQueryItem(name: "session_id", value: sessionID)
    ]
    
    sut.service.createList(param) { _ in }
    XCTAssertTrue(sut.client.executeCalled)
    let request: URLRequest = .queryParams("list",
                                           param: (query, param),
                                           httpMethod: .post)
    XCTAssertEqual(sut.client.inputRequest, request)
  }

  func test_deleteListRequest() {
    let sut = makeSUT()

    let query = [
      URLQueryItem(name: "session_id", value: sessionID)
    ]
    
    sut.service.deleteList(10) { _ in }
    XCTAssertTrue(sut.client.executeCalled)
    let request: URLRequest = .queryParams("list/10",
                                           param: (query, nil),
                                           httpMethod: .delete)
    XCTAssertEqual(sut.client.inputRequest, request)
  }
  
  func test_listDetailRequest() {
    let sut = makeSUT()
    
    sut.service.listDetail(10) { _ in }
    XCTAssertTrue(sut.client.executeCalled)
    let request: URLRequest = .queryParams("list/10",
                                           param: ([], nil),
                                           httpMethod: .get)
    XCTAssertEqual(sut.client.inputRequest, request)
  }
  
  func test_movieToListRequest() {
    let sut = makeSUT()
    let param = MovieToListParam(mediaID: 10)
    
    let query = [
      URLQueryItem(name: "session_id", value: sessionID)
    ]
    
    sut.service.movieToList(1, param: param) { _ in }
    XCTAssertTrue(sut.client.executeCalled)
    let request: URLRequest = .queryParams("list/1/add_item",
                                           param: (query, param),
                                           httpMethod: .post)
    XCTAssertEqual(sut.client.inputRequest, request)
  }
  
  func test_removeMovieRequest() {
    let sut = makeSUT()
    
    let param = RemoveMovieParam(mediaID: 1234)

    let query = [
      URLQueryItem(name: "session_id", value: sessionID)
    ]
    
    sut.service.removeMovie(10, param: param) { _ in }
    XCTAssertTrue(sut.client.executeCalled)
    let request: URLRequest = .queryParams("list/10/remove_item",
                                           param: (query, param),
                                           httpMethod: .post)
    XCTAssertEqual(sut.client.inputRequest, request)
  }
  
  func test_getAccountRequestSuccessResponse() throws {

    let results = SharedTestHelpers.getResponce(file: "Account", type: AccountModel.self)

    guard
      let response = results.responce,
          let account = results.item
    else {
      return
    }
    
    let sut = makeSUT()
    sut.client.result = .success(response)

    var result: Result<AccountModel, APIError>?

    sut.service.getAccount { result = $0 }

    XCTAssertEqual(result?.value, account)
  }

  func test_getListsSuccessResponse() throws {
    let results = SharedTestHelpers.getResponce(file: "ListModel", type: ListResponce.self)

    guard
      let response = results.responce,
          let list = results.item
    else {
      return
    }

    let sut = makeSUT()
    sut.client.result = .success(response)

    var result: Result<ListResponce, APIError>?

    sut.service.getLists(1) { result = $0 }
    XCTAssertEqual(result?.value, list)
  }

  func test_getFavoriteMoviesSuccessResponse() throws {
    let results = SharedTestHelpers.getResponce(file: "Movie", type: MovieResponce.self)

    guard
      let response = results.responce,
          let movie = results.item
    else {
      return
    }

    let sut = makeSUT()
    sut.client.result = .success(response)

    var result: Result<MovieResponce, APIError>?

    sut.service.getFavoriteMovies(1) { result = $0 }
    XCTAssertEqual(result?.value, movie)
  }

  func test_markAsFavoriteSuccessResponse() throws {
    let item = SuccessErrorModel(statusCode: 10, statusMessage: "The item/record was updated successfully")
    let response = try JSONEncoder().encode(item)

    let param = ListFavoriteParam(mediaType: "movie", mediaID: 555, favorite: true)
    
    let sut = makeSUT()
    sut.client.result = .success(response)

    var result: Result<SuccessErrorModel, APIError>?

    sut.service.markAsFavorite(param) { result = $0 }
    XCTAssertEqual(result?.value, item)
  }
  
  func test_createListSuccessResponse() throws {
    let item = NewListResponce(statusMessage: "The item/record was created successfully.",
                               success: true, statusCode: 4, listId: 5861)
    let response = try JSONEncoder().encode(item)

    let param = NewListParam(name: "New list")
    
    let sut = makeSUT()
    sut.client.result = .success(response)

    var result: Result<NewListResponce, APIError>?

    sut.service.createList(param) { result = $0 }
    XCTAssertEqual(result?.value, item)
  }
  
  func test_deleteListSuccessResponse() throws {
    let item = SuccessErrorModel(statusCode: 12, statusMessage: "The item/record was updated successfully")
    let response = try JSONEncoder().encode(item)

    let sut = makeSUT()
    sut.client.result = .success(response)

    var result: Result<SuccessErrorModel, APIError>?

    sut.service.deleteList(10) { result = $0 }
    XCTAssertEqual(result?.value, item)
  }
  
  func test_listDetailSuccessResponse() throws {
    let results = SharedTestHelpers.getResponce(file: "ListDetail", type: ListDetailResponce.self)

    guard
      let response = results.responce,
          let movie = results.item
    else {
      return
    }

    let sut = makeSUT()
    sut.client.result = .success(response)

    var result: Result<ListDetailResponce, APIError>?

    sut.service.listDetail(10) { result = $0 }
    XCTAssertEqual(result?.value, movie)
  }
  
  func test_movieToListSuccessResponse() throws {
    let item = SuccessErrorModel(statusCode: 12, statusMessage: "The item/record was updated successfully")
    let response = try JSONEncoder().encode(item)

    let param = MovieToListParam(mediaID: 10)
    
    let sut = makeSUT()
    sut.client.result = .success(response)

    var result: Result<SuccessErrorModel, APIError>?

    sut.service.movieToList(1, param: param) { result = $0 }
    XCTAssertEqual(result?.value, item)
  }
  
  func test_removeMovieSuccessResponse() throws {
    let item = SuccessErrorModel(statusCode: 12, statusMessage: "The item/record was updated successfully")
    let response = try JSONEncoder().encode(item)

    let param = RemoveMovieParam(mediaID: 1234)
    
    let sut = makeSUT()
    sut.client.result = .success(response)

    var result: Result<SuccessErrorModel, APIError>?

    sut.service.removeMovie(10, param: param) { result = $0 }
    XCTAssertEqual(result?.value, item)
  }
  
  private func makeSUT() -> (service: AccountAndListService, client: MockHTTPClient) {
    let httpClient = MockHTTPClient()
    let sut = AccountAndListService(client: httpClient)
    return (sut, httpClient)
  }
}
