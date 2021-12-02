//
//  FavoritePresenterTest.swift
//  MovieAppTests
//
//  Created by rasul on 11/14/21.
//
import XCTest
@testable import MovieApp

class FavoritePresenterTest: XCTestCase {
  
  func test_getMoviesSuccess() {
    let results = SharedTestHelpers.getResponce(file: "Movie", type: MovieResponce.self)
    
    let sut = makeSUT()
    
    guard let movie = results.item else { return }
    
    sut.serviceAccount.getFavoriteMoviesHandler = { _, completion in
      completion(.success(movie))
    }
    
    sut.serviceAccount.getFavoriteMovies(1) { result in
      switch result {
      case .success(let item):
        XCTAssertEqual(item, results.item)
        sut.view.success(items: item.results, state: .noRefresh)
      case .failure(let error):
        sut.view.failure(error: error)
      }
      
      sut.presenter.getFavoriteMovie(state: .noRefresh)
      
      XCTAssertEqual(sut.view.successCallCount, 1)
      XCTAssertEqual(sut.view.failureCallCount, 0)
      XCTAssertEqual(sut.serviceAccount.getFavoriteMoviesCallCount, 2)
    }
  }
  
  func test_getMoviesFailure() {
    let sut = makeSUT()
    
    sut.serviceAccount.getFavoriteMoviesHandler = { _, completion in
      completion(.failure((.requestError(1, "failure"))))
    }
    
    sut.serviceAccount.getFavoriteMovies(1) { result in
      switch result {
      case .success:
        break
      case .failure(let error):
        sut.view.failure(error: error)
      }
      sut.presenter.getFavoriteMovie(state: .noRefresh)
      
      XCTAssertEqual(sut.view.successCallCount, 0)
      XCTAssertEqual(sut.view.failureCallCount, 1)
      XCTAssertEqual(sut.serviceAccount.getFavoriteMoviesCallCount, 2)
    }
  }

  func test_markAddFavoriteSuccess() {
    let sut = makeSUT()
    let responseSuccessError = SuccessErrorModel(statusCode: 12, statusMessage: "The item/record was updated successfully.")
    let param = ListFavoriteParam(mediaType: "movie", mediaID: 1, favorite: true)
    
    sut.serviceAccount.markAsFavoriteHandler = { _, completion in
      completion(.success(responseSuccessError))
    }
    
    sut.serviceAccount.markAsFavorite(param) { result in
      switch result {
      case .success(let item):
        XCTAssertEqual(item, responseSuccessError)
        sut.view.successDeleteMovie()
      case .failure(let error):
        sut.view.failure(error: error)
      }
    }
    
    sut.presenter.markAdFavorite(id: 1)
    
    XCTAssertEqual(sut.view.successDeleteMovieCallCount, 1)
    XCTAssertEqual(sut.view.failureCallCount, 0)
    XCTAssertEqual(sut.serviceAccount.markAsFavoriteCallCount, 2)
  }
  
  func test_markAddFavoriteFailure() {
    let sut = makeSUT()
    let responseSuccessError = SuccessErrorModel(statusCode: 12, statusMessage: "The item/record was updated successfully.")
    let param = ListFavoriteParam(mediaType: "movie", mediaID: 1, favorite: true)
    
    sut.serviceAccount.markAsFavoriteHandler = { _, completion in
      completion(.failure(.requestError(1, "failure")))
    }
    
    sut.serviceAccount.markAsFavorite(param) { result in
      switch result {
      case .success(let item):
        XCTAssertEqual(item, responseSuccessError)
        sut.view.successDeleteMovie()
      case .failure(let error):
        sut.view.failure(error: error)
      }
    }
    
    sut.presenter.markAdFavorite(id: 1)
    
    XCTAssertEqual(sut.view.successDeleteMovieCallCount, 0)
    XCTAssertEqual(sut.view.failureCallCount, 1)
    XCTAssertEqual(sut.serviceAccount.markAsFavoriteCallCount, 2)
  }
  
  private func makeSUT() -> (serviceAccount: AccountAndListServiceProtocolMock,
                             presenter: FavoritePresenter,
                             view: FavoriteViewInputMock,
                             persistence: MoviePersistence) {
    let serviceAccount = AccountAndListServiceProtocolMock()
    let view = FavoriteViewInputMock()
    let coredataStack = CoreDataStack(modelName: "Model", storageType: .inMemory)
    let persistence = MoviePersistence(context: coredataStack.managedContext, backgroundContext: coredataStack.managedContext)
    
    let presenter = FavoritePresenter(service: serviceAccount, view: view, persistence: persistence)
    return (serviceAccount, presenter, view, persistence)
  }
}
