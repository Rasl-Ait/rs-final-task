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
  var page = 1
  
  init(view: ListsViewInput, service: AccountAndListServiceProtocol) {
    self.view = view
    self.service = service
  }
  
  func getLists() {
    view?.showIndicator()
    service.getLists(page) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
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
