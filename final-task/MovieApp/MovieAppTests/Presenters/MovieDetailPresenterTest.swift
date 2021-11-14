//
//  MovieDetailPresenterTest.swift
//  MovieAppTests
//
//  Created by rasul on 11/14/21.
//

import XCTest
@testable import MovieApp

class MovieDetailPresenterTest: XCTestCase {
  
  func test_getMovieDetailSuccess() {
    let results = getResponce(file: "MovieDetail", type: MovieDetailModel.self)
    
    let movieId = results.item?.id
    
    let sut = makeSUT()
    sut.serviceMovie.responseMovieDetail = results.item
    
    sut.presenter.getMovie(id: movieId ?? 0)
    sut.serviceMovie.getMovie(movieId ?? 0) { result in
      switch result {
      case .success(let item):
        sut.view.success(type: .movie(item))
        XCTAssertTrue(sut.view.isCalledSuccess)
      case .failure:
        break
      }
    }
  }
  
  func test_getMovieDetailFailure() {
    let results = getResponce(file: "MovieDetail", type: MovieDetailModel.self)
    
    let movieId = results.item?.id
    
    let sut = makeSUT()
    
    sut.presenter.getMovie(id: movieId ?? 0)
    sut.serviceMovie.getMovie(movieId ?? 0) { result in
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
    
    sut.presenter.markAdFavorite(fav: true)
    sut.serviceAccount.markAsFavorite(param) { result in
      switch result {
      case .success:
        sut.view.success(type: .favorite(true))
        XCTAssertTrue(sut.view.isCalledSuccess)
      case .failure(let error):
        sut.view.failure(error: error)
      }
    }
  }
  
  func test_markAddFavoriteFailure() {
    let sut = makeSUT()
    let param = ListFavoriteParam(mediaType: "movie", mediaID: 1, favorite: true)

    sut.presenter.markAdFavorite(fav: true)
    sut.serviceAccount.markAsFavorite(param) { result in
      switch result {
      case .success:
       break
      case .failure(let error):
        sut.view.failure(error: error)
        XCTAssertFalse(sut.view.isCalledSuccess)
      }
    }
  }
  
  private func makeSUT() -> (serviceMovie: MovieServiceSpy,
                             serviceAccount: AccountAndListServiceSpy,
                             presenter: MovieDetailPresenter,
                             view: MovieDetailControllerMock) {
    let serviceMovie = MovieServiceSpy()
    let serviceAccount = AccountAndListServiceSpy()
    let view = MovieDetailControllerMock()
    
    let presenter = MovieDetailPresenter(service: serviceMovie, serviceAccount: serviceAccount, view: view, movieId: 1)
    return (serviceMovie, serviceAccount, presenter, view)
  }
}

