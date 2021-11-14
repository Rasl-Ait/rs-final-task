//
//  ListDetailPresenterTest.swift
//  MovieAppTests
//
//  Created by rasul on 11/14/21.
//

import XCTest
@testable import MovieApp

class ListDetailViewControllerMock: ListDetailViewInput {

  var isCalledFetchListsDetail: Bool!
  var isCalledRemoveMovie: Bool!
  
  func success(items: [MovieModel], state: StateLoad) {
    isCalledFetchListsDetail = true
  }
  
  func successRemoveMovie() {
    isCalledRemoveMovie = true
  }
  
  func failure(error: APIError) {
    isCalledFetchListsDetail = false
    isCalledRemoveMovie = false
  }
  
  func hideIndicator() {
    
  }
  
  func showIndicator() {
    
  }
}

class ListDetailPresenterTest: XCTestCase {
  
  func test_getListDetailSuccess() {
    let results = getResponce(file: "ListDetail", type: ListDetailResponce.self)
    
    let sut = makeSUT()
    sut.service.responseListDetail = results.item
    
    sut.presenter.getMovies(state: .noRefresh)
    sut.service.listDetail(1) { result in
      switch result {
      case .success(let item):
        sut.view.success(items: item.items, state: .noRefresh)
        XCTAssertTrue(sut.view.isCalledFetchListsDetail)
      case .failure(let error):
        sut.view.failure(error: error)
      }
    }
  }
  
  func test_getListDetailFailure() {
    let sut = makeSUT()
    
    sut.presenter.getMovies(state: .noRefresh)
    sut.service.listDetail(1) { result in
      switch result {
      case .success(let item):
        sut.view.success(items: item.items, state: .noRefresh)
        XCTAssertTrue(sut.view.isCalledFetchListsDetail)
      case .failure(let error):
        sut.view.failure(error: error)
        XCTAssertFalse(sut.view.isCalledFetchListsDetail)
      }
    }
  }
  
  func test_deleteMovieFromListSuccess() {
    
    let results = getResponce(file: "Movie", type: MovieResponce.self)
    let movie = results.item?.results.first
    
    let responseSuccessError = SuccessErrorModel(statusCode: 12, statusMessage: "The item/record was updated successfully.")
    
    let param = RemoveMovieParam(mediaID: movie?.id ?? 0)
    
    let sut = makeSUT()
    sut.service.responseSuccessError = responseSuccessError
    
    sut.presenter.removeMovie(item: movie!)
    sut.service.removeMovie(movie?.id ?? 0, param: param) { result in
      switch result {
      case .success:
        sut.view.successRemoveMovie()
        XCTAssertTrue(sut.view.isCalledRemoveMovie)
      case .failure(let error):
        sut.view.failure(error: error)
      }
    }
  }

  func test_deleteMovieFromListFailure() {
    
    let results = getResponce(file: "Movie", type: MovieResponce.self)
    let movie = results.item?.results.first
    
    let param = RemoveMovieParam(mediaID: movie?.id ?? 0)
    
    let sut = makeSUT()
    
    sut.presenter.removeMovie(item: movie!)
    sut.service.removeMovie(movie?.id ?? 0, param: param) { result in
      switch result {
      case .success:
        sut.view.successRemoveMovie()
        XCTAssertTrue(sut.view.isCalledRemoveMovie)
      case .failure(let error):
        sut.view.failure(error: error)
        XCTAssertFalse(sut.view.isCalledRemoveMovie)
      }
    }
  }
  
  private func makeSUT() -> (service: AccountAndListServiceSpy, presenter: ListDetailPresenter, view: ListDetailViewControllerMock) {
    let service = AccountAndListServiceSpy()
    let view = ListDetailViewControllerMock()
    let coredataStack = CoreDataStack(modelName: "Model", storageType: .inMemory)
    let persistence = MoviePersistence(context: coredataStack.managedContext, backgroundContext: coredataStack.managedContext)
    
    let results = getResponce(file: "ListModel", type: ListResponce.self)
    
    let list = results.item?.results.first!
    
  let presenter = ListDetailPresenter(view: view, service: service, list: list!, persistence: persistence)
    return (service, presenter, view)
  }
}
