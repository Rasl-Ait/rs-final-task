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
  private let serviceAuth: AuthServiceProtocol
  private let persistence: StorageProtocol
  private var page = 1
  
  var param: NewListParam?
  var mediaID: Int?

  init(
    view: ListsViewInput,
    service: AccountAndListServiceProtocol,
    persistence: StorageProtocol,
    mediaID: Int?,
    serviceAuth: AuthServiceProtocol) {
    self.view = view
    self.service = service
    self.persistence = persistence
    self.mediaID = mediaID
    self.serviceAuth = serviceAuth
  }
  
  func getAccount(completion: @escaping VoidClosure) {
    service.getAccount { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        UserDefaults.standard.accountID = item.id
      completion()
      case .failure(let error):
        if InternetConnection().isConnectedToNetwork() == true {
          mainQueue {
            self.view?.failure(error: error)
          }
        } else {
          self.persistence.fetch(nil)
          mainQueue {
            self.view?.success(items: self.persistence.items)
          }
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
          item.results.compactMap { $0 }.forEach(self.persistence.addList)
          mainQueue {
            self.lists = item.results
            self.view?.success(items: item.results)
          }
        case .failure(let error):
          mainQueue {
            self.view?.failure(error: error)
          }
        }
      }
    }
  }
  
  func createList() {
    view?.showIndicator()
    guard let param = param else {
      return
    }
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
  
  func logout() {
    view?.showIndicator()
    let param = SessionParam(id: UserDefaults.standard.sessionID)
    serviceAuth.logout(param) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        if item.success {
          UserDefaults.standard.sessionID = ""
        }
        mainQueue {
          self.view?.hideIndicator()
          self.coordinator?.pushAuthVC()
        }
      case .failure(let error):
        mainQueue {
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
  
  func pop() {
    coordinator?.pop()
  }
}
