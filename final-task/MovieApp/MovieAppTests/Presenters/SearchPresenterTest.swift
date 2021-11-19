//
//  SearchPresenterTest.swift
//  MovieAppTests
//
//  Created by rasul on 11/14/21.
//

import XCTest
@testable import MovieApp

class SearchPresenterTest: XCTestCase {
  
  func test_getMoviesSuccess() {
    let results = SharedTestHelpers.getResponce(file: "Movie", type: MovieResponce.self)
    let param = SearchParam(query: "Venom", page: 1, includeAdult: false)
    
    let sut = makeSUT()
    
    guard let movie = results.item else { return }
    
    sut.service.searchHandler = { _, completion in
      completion(.success(movie))
    }
    
    sut.service.search(param) { result in
      switch result {
      case .success(let item):
        XCTAssertEqual(item, results.item)
        sut.view.success(items: item.results)
      case .failure(let error):
        sut.view.failure(error: error)
      }
    }
    
    sut.presenter.search(searchText: param.query)
    
    XCTAssertEqual(sut.view.successCallCount, 1)
    XCTAssertEqual(sut.view.failureCallCount, 0)
    XCTAssertEqual(sut.service.searchCallCount, 2)
  }
  
  func test_getMoviesFailure() {
    let param = SearchParam(query: "Venom", page: 1, includeAdult: false)
    
    let sut = makeSUT()

    sut.service.searchHandler = { _, completion in
      completion(.failure(.requestError(1, "failure")))
    }
    
    sut.service.search(param) { result in
      switch result {
      case .success(let item):
        sut.view.success(items: item.results)
        break
      case .failure(let error):
        sut.view.failure(error: error)
      }
    }
    
    sut.presenter.search(searchText: param.query)
    
    XCTAssertEqual(sut.view.successCallCount, 0)
    XCTAssertEqual(sut.view.failureCallCount, 1)
    XCTAssertEqual(sut.service.searchCallCount, 2)
  }
  
  func test_push() {
    let sut = makeSUT()
    sut.presenter.push(id: 10)
  }
  
  private func makeSUT() -> (service: SearchServiceProtocolMock,
                             presenter: SearchPresenter,
                             view: SearchViewInputMock) {
    let service = SearchServiceProtocolMock()
    let view = SearchViewInputMock()
    let coordinator = SearchCoordinatorProtocolMock()
    let presenter = SearchPresenter(service: service, view: view)
    presenter.coordinator = coordinator
    return (service, presenter, view)
  }
}
