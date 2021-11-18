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
    let results = SharedTestHelpers.getResponce(file: "MovieModel", type: MovieResponce.self)
    
    let sut = makeSUT()
    sut.serviceAccount.responseMovie = results.item
    
    sut.presenter.getFavoriteMovie(state: .noRefresh)
    sut.serviceAccount.getFavoriteMovies(1) { result in
      switch result {
      case .success(let item):
        sut.view.success(items: item.results, state: .noRefresh)
        XCTAssertTrue(sut.view.isCalledSuccess)
      case .failure:
        break
      }
    }
  }
  
  func test_getMoviesFailure() {
    let sut = makeSUT()
    
    sut.presenter.getFavoriteMovie(state: .noRefresh)
    sut.serviceAccount.getFavoriteMovies(1) { result in
      switch result {
      case .success:
       break
      case .failure(let error):
        sut.view.failure(error: error)
        XCTAssertFalse(sut.view.isCalledSuccess)
      }
    }
  }
  
  func test_markAddFavoriteSuccess() {
    let sut = makeSUT()
    let responseSuccessError = SuccessErrorModel(statusCode: 12, statusMessage: "The item/record was updated successfully.")
    let param = ListFavoriteParam(mediaType: "movie", mediaID: 1, favorite: true)

    sut.serviceAccount.responseSuccessError = responseSuccessError

    sut.presenter.markAdFavorite(id: 1)
    sut.serviceAccount.markAsFavorite(param) { result in
      switch result {
      case .success:
        sut.view.successDeleteMovie()
        XCTAssertTrue(sut.view.isDeleteSuccess)
      case .failure:
        break
      }
    }
  }

  func test_markAddFavoriteFailure() {
    let sut = makeSUT()
    let param = ListFavoriteParam(mediaType: "movie", mediaID: 1, favorite: true)

    sut.presenter.markAdFavorite(id: 1)
    sut.serviceAccount.markAsFavorite(param) { result in
      switch result {
      case .success:
       break
      case .failure(let error):
        sut.view.failure(error: error)
        XCTAssertFalse(sut.view.isDeleteSuccess)
      }
    }
  }
  
  private func makeSUT() -> (serviceAccount: AccountAndListServiceSpy,
                             presenter: FavoritePresenter,
                             view: FavoriteControllerMock) {
    let serviceAccount = AccountAndListServiceSpy()
    let view = FavoriteControllerMock()
    let coredataStack = CoreDataStack(modelName: "Model", storageType: .inMemory)
    let persistence = MoviePersistence(context: coredataStack.managedContext, backgroundContext: coredataStack.managedContext)
    
    let presenter = FavoritePresenter(service: serviceAccount, view: view, persistence: persistence)
    return (serviceAccount, presenter, view)
  }
}
