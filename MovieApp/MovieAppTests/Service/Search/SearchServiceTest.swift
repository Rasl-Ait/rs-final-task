//
//  SearchServiceTest.swift
//  MovieAppTests
//
//  Created by rasul on 11/12/21.
//

import XCTest
@testable import MovieApp

class SearchServiceTest: XCTestCase {
  
  func test_searchRequest() {
    let sut = makeSUT()
    
    let param = SearchParam(query: "venom", page: 1, includeAdult: false)
    let queryParam = param.getParam(param: param)
    
    sut.service.search(param) { _ in }
    XCTAssertTrue(sut.client.executeCalled)
    XCTAssertEqual(sut.client.inputRequest, .queryParams("search/movie", param: (queryParam, nil)))
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
    let param = SearchParam(query: "venom", page: 1, includeAdult: false)
    var result: Result<MovieResponce, APIError>?

    sut.service.search(param) { result = $0 }
    XCTAssertEqual(result?.value, movie)
  }
  
  private func makeSUT() -> (service: SearchService, client: MockHTTPClient) {
    let httpClient = MockHTTPClient()
    let sut = SearchService(client: httpClient)
    return (sut, httpClient)
  }
}
