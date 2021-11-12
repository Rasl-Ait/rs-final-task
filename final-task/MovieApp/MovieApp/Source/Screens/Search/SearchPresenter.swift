//
//  SearchPresenter.swift
//  MovieApp
//
//  Created by rasul on 11/12/21.
//  
//

import Foundation

final class SearchPresenter: SearchViewOutput {
	private let service: SearchServiceProtocol
	weak var view: SearchViewInput?
  var coordinator: SearchCoordinatorProtocol?
  
  private var page = 1
  
	init(service: SearchServiceProtocol, view: SearchViewInput) {
		self.service = service
		self.view = view
	}
  
  func search(searchText: String) {
    view?.showIndicator()
    let param = SearchParam(query: searchText, page: page, includeAdult: false)
    service.search(param) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
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
  
  func push(id: Int) {
    coordinator?.pushMovieDetailVC(id: id)
  }
}
