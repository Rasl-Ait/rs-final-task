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
  
  var page = 1
  var isFetching = false
  private var results: [MovieModel] = []
  
	init(service: SearchServiceProtocol, view: SearchViewInput) {
		self.service = service
		self.view = view
	}
  
  func search(searchText: String) {
    view?.showIndicator()
    isFetching = true
    let param = SearchParam(query: searchText, page: page, includeAdult: false)
    service.search(param) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        
        mainQueue {
          self.isFetching = self.page == item.totalPages
          self.page += 1
          self.results.append(contentsOf: item.results)
          self.view?.success(items: self.results)
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
