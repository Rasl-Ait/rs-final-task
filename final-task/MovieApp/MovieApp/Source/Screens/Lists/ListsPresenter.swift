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
  weak var coordinator: ListsCoordinatorProtocol?
  
  private(set) var lists: [ListModel] = []
  
  let service: AccountAndListServiceProtocol
  let persistence: StorageProtocol
  var page = 1
  private var param: NewListParam!
  
  init(view: ListsViewInput, service: AccountAndListServiceProtocol, persistence: StorageProtocol) {
    self.view = view
    self.service = service
    self.persistence = persistence
  }
  
  func getLists() {
    view?.showIndicator()
    service.getLists(page) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        mainQueue {
          self.view?.success(items: item.results)
          item.results.compactMap { $0 }.forEach(self.persistence.add)
        }
      case .failure(let error):
        mainQueue {
          self.view?.failure(error: error)
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
  
  func addText(name: String) {
    param = NewListParam(name: name)
  }
}
