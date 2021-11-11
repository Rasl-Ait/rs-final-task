//
//  ListsPresenter.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//  
//

import Foundation

final class ListsPresenter: ListsViewOutput {
  weak var view: ListsViewInput?
  var coordinator: ListsCoordinatorProtocol?
  
  private(set) var lists: [ListModel] = []
  
  private let service: AccountAndListServiceProtocol
  private let persistence: StorageProtocol
  private var page = 1
  
  private var param: NewListParam!
  private var mediaID: Int?

  init(
    view: ListsViewInput,
    service: AccountAndListServiceProtocol,
    persistence: StorageProtocol,
    mediaID: Int?) {
    self.view = view
    self.service = service
    self.persistence = persistence
    self.mediaID = mediaID
  }
  
  func getAccount(completion: @escaping VoidClosure) {
    service.getAccount() { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        UserDefaults.standard.accountID = item.id
      completion()
      case .failure(let error):
        print(error.localizedDescription)
        mainQueue {
          self.view?.failure(error: error)
        }
      }
    }
  }
  
  func getLists(state: StateLoad) {
    if state != .refresh {
      view?.showIndicator()
    } else {
      page = 1
    }
    
    self.getAccount { [weak self] in
      guard let self = self else { return }
      self.service.getLists(self.page) { [weak self] result in
        guard let self = self else { return }
        switch result {
        case .success(let item):
          mainQueue {
            self.lists = item.results
            self.view?.success(items: item.results)
            item.results.compactMap { $0 }.forEach(self.persistence.addList)
          }
        case .failure(let error):
          print(error.localizedDescription)
          mainQueue {
            self.view?.failure(error: error)
          }
        }
      }
    }
  }
  
  func createList() {
    view?.showIndicator()
    service.createList(param) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        mainQueue {
          self.view?.successCreateList(text: item.statusMessage)
        }
      case .failure(let error):
        mainQueue {
          self.view?.failure(error: error)
        }
      }
    }
  }
  
  func deleteList(id: Int) {
    service.deleteList(id) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        mainQueue {
          self.persistence.remove(with: id)
          self.view?.successDeleteList(text: item.statusMessage)
        }
      case .failure(let error):
        mainQueue {
          self.persistence.remove(with: id)
          self.view?.failure(error: error)
        }
      }
    }
  }
  
  func addMovieToList(id: Int, mediaID: Int) {
    view?.showIndicator()
    let param = MovieToListParam(mediaID: mediaID)
    service.movieToList(id, param: param) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        mainQueue {
          self.view?.successAddMovieToList(text: item.statusMessage)
        }
      case .failure(let error):
        mainQueue {
          self.view?.failure(error: error)
        }
      }
    }
  }
  
  func addText(name: String) {
    param = NewListParam(name: name)
  }
  
  func didSelectRowAt(list: ListModel) {
    
    if mediaID != nil {
      addMovieToList(id: list.id, mediaID: mediaID ?? 0)
    } else {
      coordinator?.pushListDetailVC(list: list)
    }
  }
}
