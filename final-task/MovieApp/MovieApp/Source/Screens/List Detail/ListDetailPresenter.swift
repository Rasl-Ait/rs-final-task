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
        
//        item.items.forEach {
//          //persistence.addMovie($0, list: list)
//        }
        
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
  
  func removeMovie(id: Int) {
    let param = RemoveMovieParam(mediaID: id)
    self.view?.showIndicator()
    service.removeMovie(list.id, param: param) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success:
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
}
