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
	weak var view: MovieDetailViewInput?
  
  private var movieId: Int
  private var page = 1
		
	init(
    service: MovieServiceProtocol,
    view: MovieDetailViewInput,
    movieId: Int) {
		self.service = service
		self.view = view
    self.movieId = movieId
	}
  
  func getMovie() {
    view?.showIndicator()
    service.getMovie(movieId) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        mainQueue {
          self.view?.success(type: .movie(item))
        }
        
        self.getVideo()
        self.getSimilarMovie()
      case .failure(let error):
        mainQueue {
          self.view?.failure(error: error)
        }
      }
    }
  }
  
  func getVideo() {
    service.getVideo(movieId) { [weak self] result in
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
  
  func getSimilarMovie() {
    service.getMovieSimilar(movieId, page: page) { [weak self] result in
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
}
