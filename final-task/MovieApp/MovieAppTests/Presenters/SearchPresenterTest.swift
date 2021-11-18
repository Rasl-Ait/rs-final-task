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
    let results = SharedTestHelpers.getResponce(file: "MovieModel", type: MovieResponce.self)
    let param = SearchParam(query: "Venom", page: 1, includeAdult: false)
    
    let sut = makeSUT()
    sut.service.responseMovie = results.item
    
    sut.presenter.search(searchText: "Venom")
    sut.service.search(param) { result in
      switch result {
      case .success(let item):
        sut.view.success(items: item.results)
        XCTAssertTrue(sut.view.isCalledSuccess)
      case .failure:
        break
      }
    }
  }
  
  func test_getMoviesFailure() {
    let param = SearchParam(query: "Venom", page: 1, includeAdult: false)
    let sut = makeSUT()
    
    sut.presenter.search(searchText: "Venom")
    sut.service.search(param) { result in
      switch result {
      case .success:
      break
      case .failure(let error):
        sut.view.failure(error: error)
        XCTAssertFalse(sut.view.isCalledSuccess)
      }
    }
  }
  
  private func makeSUT() -> (service: SearchServiceSpy,
                             presenter: SearchPresenter,
                             view: SearchControllerMock) {
    let service = SearchServiceSpy()
    let view = SearchControllerMock()
    let presenter = SearchPresenter(service: service, view: view)
    return (service, presenter, view)
  }
}
