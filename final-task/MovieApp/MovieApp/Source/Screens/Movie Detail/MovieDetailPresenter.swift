//
//  MovieDetailPresenter.swift
//  MovieApp
//
//  Created by rasul on 11/10/21.
//  
//

import Foundation

final class MovieDetailPresenter: MovieDetailViewOutput {
	private let service: MovieServiceProtocol
  private let serviceAccount: AccountAndListServiceProtocol
	weak var view: MovieDetailViewInput?
  var coordinator: ListDetailCoordinatorProtocol?
  
  var movieID: Int
  private var page = 1
  private var movie: MovieDetailModel?
		
	init(
    service: MovieServiceProtocol,
    serviceAccount: AccountAndListServiceProtocol,
    view: MovieDetailViewInput,
    movieId: Int) {
    self.serviceAccount = serviceAccount
		self.service = service
		self.view = view
    self.movieID = movieId
	}
  
  func getMovie(id: Int) {
    view?.showIndicator()
    service.getMovie(id) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        mainQueue {
          self.movie = item
          self.view?.success(type: .movie(item))
        }
        
        self.getMovieState(id)
        self.getVideo(id: id)
        self.getSimilarMovie(id: id)
      case .failure(let error):
        mainQueue {
          self.view?.failure(error: error)
        }
      }
    }
  }
  
  func getVideo(id: Int) {
    service.getVideo(id) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        mainQueue {
          self.view?.success(type: .video(item.results))
        }
      case .failure(let error):
        mainQueue {
          self.view?.failure(error: error)
        }
      }
    }
  }
  
  func getSimilarMovie(id: Int) {
    service.getMovieSimilar(id, page: page) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        mainQueue {
          self.view?.success(type: .similarVideo(item.results))
        }
      case .failure(let error):
        mainQueue {
          self.view?.failure(error: error)
        }
      }
    }
  }
  
  func getMovieState(_ id: Int) {
    service.getAccountStates(id) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        mainQueue {
          self.view?.success(type: .favorite(item.favorite))
        }
      case .failure(let error):
        mainQueue {
          self.view?.failure(error: error)
        }
      }
    }
  }
  
  func markAdFavorite(fav: Bool) {
    let param = ListFavoriteParam(mediaType: "movie", mediaID: movieID, favorite: fav)
    serviceAccount.markAsFavorite(param) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success:
        self.getMovieState(self.movieID)
      case .failure(let error):
        mainQueue {
          self.view?.failure(error: error)
        }
      }
    }
  }
  
  func didButtonClicked(type: BlurButtonType) {
    switch type {
    case .close:
      coordinator?.dissmiss()
    case .info:
      coordinator?.pushWebViewVC(stringURL: movie?.homepage ?? "")
    case .list:
      coordinator?.pushList(mediaID: movie?.id ?? 0)
    case .favorite(let fav):
      markAdFavorite(fav: fav)
    default:
      break
    }
  }
}
