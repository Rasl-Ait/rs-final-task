//
//  ListDetailPresenter.swift
//  MovieApp
//
//  Created by rasul on 11/7/21.
//  
//

import Foundation

final class ListDetailPresenter: ListDetailViewOutput {
  // MARK: - Properties
  private(set) var alertTitles = ["Date", "Popular", "Rate"]
  
	private let service: AccountAndListServiceProtocol
  private let persistence: StorageProtocol
  
	weak var view: ListDetailViewInput?
  weak var coordinator: ListDetailCoordinatorProtocol?
  
  private let list: ListModel
  private let imageManager = ImageManager()
  
  var title: String {
    list.name
  }
  
  init(
    view: ListDetailViewInput,
    service: AccountAndListServiceProtocol,
    list: ListModel,
    persistence: StorageProtocol) {
    self.service = service
    self.view = view
    self.list = list
    self.persistence = persistence
  }
  
  func getMovies(state: StateLoad) {
    if state != .refresh {
      self.view?.showIndicator()
    }
    
    service.listDetail(list.id) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        
        item.items.forEach {
          var movie = $0
          movie.posterPath = self.imageManager.saveNewMemory(imageString: movie.iconString ?? "", key: movie.posterPath ?? "")
          self.persistence.addMovie(movie, listID: self.list.id)
        }
        
        mainQueue {
          self.view?.success(items: item.items)
        }
      case .failure(let error):
        mainQueue {
          self.view?.failure(error: error)
        }
      }
    }
  }
  
  func removeMovie(item: MovieModel) {
    let param = RemoveMovieParam(mediaID: item.id)
    self.view?.showIndicator()
    service.removeMovie(list.id, param: param) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success:
        self.persistence.removeMovie(with: item.id)
        self.imageManager.remove(filename: item.posterPath ?? "")
        
        mainQueue {
          self.view?.successRemoveMovie()
        }
      case .failure(let error):
        mainQueue {
          self.view?.failure(error: error)
        }
      }
    }
  }
  
  deinit {
    print("delete prenseter")
  }
  
  func viewWillDisappear() {
    coordinator?.pop()
  }
  
  func push(id: Int) {
    coordinator?.pushMovieDetailVC(id: id)
  }
}
