//
//  FavoritePresenter.swift
//  MovieApp
//
//  Created by rasul on 11/12/21.
//  
//

import Foundation

final class FavoritePresenter: FavoriteViewOutput {
	private let service: AccountAndListServiceProtocol
  private let persistence: StorageProtocol
	weak var view: FavoriteViewInput?
  weak var coordinator: FavoriteCoordinatorProtocol?
  
  private var page = 1
  
  init(
    service: AccountAndListServiceProtocol,
    view: FavoriteViewInput,
    persistence: StorageProtocol) {
    self.service = service
    self.view = view
    self.persistence = persistence
  }
  
  func getFavoriteMovie() {
    view?.showIndicator()
    service.getFavoriteMovies(1) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        
        item.results.compactMap { $0 }.forEach(self.persistence.addFavoriteMovie)
        
        mainQueue {
          self.view?.success(items: item.results)
        }
      case .failure(let error):
        mainQueue {
          self.view?.failure(error: error)
        }
      }
    }
  }
  
  func markAdFavorite(id: Int) {
    let param = ListFavoriteParam(mediaType: "movie", mediaID: id, favorite: false)
    service.markAsFavorite(param) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success:
        self.persistence.removeFavoriteMovie(with: id)
        mainQueue {
          self.view?.successDeleteMovie()
        }
      case .failure(let error):
        mainQueue {
          self.view?.failure(error: error)
        }
      }
    }
  }
  
  func didSelect(type: FavoriteTappedType) {
    switch type {
    case .cell(let id):
      coordinator?.pushMovieDetailVC(id: id)
    case .favorite(let id):
      markAdFavorite(id: id)
    }
  }
}
