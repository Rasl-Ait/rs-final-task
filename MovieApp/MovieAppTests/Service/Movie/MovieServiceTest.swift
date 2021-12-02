//
//  MovieServiceTest.swift
//  MovieAppTests
//
//  Created by rasul on 11/10/21.
//

import XCTest
@testable import MovieApp

class MovieServiceTest: XCTestCase {
  
  let accountID = UserDefaults.standard.accountID
  let sessionID = UserDefaults.standard.sessionID
  
  func test_getMovieRequest() {
    let sut = makeSUT()
    
    sut.service.getMovie(10) { _ in }
    XCTAssertTrue(sut.client.executeCalled)
    XCTAssertEqual(sut.client.inputRequest, .queryParams("movie/10", param: ([], nil)))
  }
  
  func test_getMovieVideoRequest() {
    let sut = makeSUT()
    sut.service.getVideo(10) { _ in }
    XCTAssertTrue(sut.client.executeCalled)
    let request: URLRequest = .queryParams("movie/\(10)/videos",
                                           param: ([], nil),
                                           httpMethod: .get)
    XCTAssertEqual(sut.client.inputRequest, request)
  }

  func test_getMovieSimilarRequest() {
    let sut = makeSUT()
    let param = [
      URLQueryItem(name: "page", value: 1.toString)
    ]
    sut.service.getMovieSimilar(10, page: 1) { _ in }
    XCTAssertTrue(sut.client.executeCalled)
    let request: URLRequest = .queryParams("movie/\(10)/similar",
                                           param: (param, nil),
                                           httpMethod: .get)
    XCTAssertEqual(sut.client.inputRequest, request)
  }

  func test_rateMovieRequest() {
    let sut = makeSUT()
    let param = MovieRateParam(value: 5)

    let query = [
      URLQueryItem(name: "session_id", value: sessionID)
    ]

    sut.service.movieRate(10, param: param) { _ in }
    XCTAssertTrue(sut.client.executeCalled)
    let request: URLRequest = .queryParams("movie/\(10)/rating",
                                           param: (query, param),
                                           httpMethod: .post)
    XCTAssertEqual(sut.client.inputRequest, request)
  }

  func test_getAccountStateRequest() {
    let sut = makeSUT()

    let query = [
      URLQueryItem(name: "session_id", value: sessionID)
    ]

    sut.service.getAccountStates(10) { _ in }
    XCTAssertTrue(sut.client.executeCalled)
    let request: URLRequest = .queryParams("movie/\(10)/account_states",
                                           param: (query, nil),
                                           httpMethod: .get)
    XCTAssertEqual(sut.client.inputRequest, request)
  }
  
  func test_getMoviesRequestSuccessResponse() throws {

    let results = SharedTestHelpers.getResponce(file: "MovieDetail", type: MovieDetailModel.self)

    guard
      let response = results.responce,
          let movie = results.item
    else {
      return
    }

    let sut = makeSUT()
    sut.client.result = .success(response)

    var result: Result<MovieDetailModel, APIError>?

    sut.service.getMovie(10) { result = $0 }

    XCTAssertEqual(result?.value, movie)
  }

  func test_getVideoSuccessResponse() throws {
    let results = SharedTestHelpers.getResponce(file: "MovieVideo", type: ResultsVideo.self)

    guard
      let response = results.responce,
      let videos = results.item
    else {
      return
    }

    let sut = makeSUT()
    sut.client.result = .success(response)

    var result: Result<ResultsVideo, APIError>?

    sut.service.getVideo(10) { result = $0 }
    XCTAssertEqual(result?.value, videos)
  }
  
  func test_getMovieSimilarSuccessResponse() throws {
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

    sut.service.getMovieSimilar(10, page: 1) { result = $0 }
    XCTAssertEqual(result?.value, movie)
  }
  
  func test_rateMovieSuccessResponse() throws {
    let item = SuccessErrorModel(statusCode: 10, statusMessage: "The item/record was updated successfully")
    let response = try JSONEncoder().encode(item)

    let param = MovieRateParam(value: 5)

    let sut = makeSUT()
    sut.client.result = .success(response)

    var result: Result<SuccessErrorModel, APIError>?

    sut.service.movieRate(10, param: param) { result = $0 }
    XCTAssertEqual(result?.value, item)
  }
  
  func test_AccountStatesSuccessResoponse() throws {
    let item = MovieStates(id: 1, favorite: true, rated: false, watchlist: false)
    let response = try JSONEncoder().encode(item)

    let sut = makeSUT()
    sut.client.result = .success(response)

    var result: Result<MovieStates, APIError>?

    sut.service.getAccountStates(1) { result = $0 }
    XCTAssertEqual(result?.value, item)
  }
  
  private func makeSUT() -> (service: MovieService, client: MockHTTPClient) {
    let httpClient = MockHTTPClient()
    let sut = MovieService(client: httpClient)
    return (sut, httpClient)
  }
}
