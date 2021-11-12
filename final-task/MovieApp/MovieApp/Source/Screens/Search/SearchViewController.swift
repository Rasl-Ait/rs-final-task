//
//  SearchViewController.swift
//  MovieApp
//
//  Created by rasul on 11/12/21.
//  
//

import UIKit

final class SearchViewController: BaseViewController {
  // MARK: - Properties
  private lazy var searchView = makeSearchView()
  private let searchController = UISearchController(searchResultsController: nil)
  
	var presenter: SearchViewOutput!
    
	override func viewDidLoad() {
		super.viewDidLoad()
    setupViews()
	}
}

// MARK: - Private Extension
private extension SearchViewController {
  func setupViews() {
    setupSearchBar()
    setupAppearence()
    setupLayoutUI()
    
    searchView.didSelectRowAt = { [weak self] id in
      guard let self = self else { return }
      self.presenter.push(id: id)
    }
  }
  
  func setupAppearence() {
    view.addSubview(searchView)
  }
  
  func setupSearchBar() {
    searchController.searchBar.placeholder = "Search for a movie"
    searchController.searchBar.barStyle = .default
    searchController.searchBar.tintColor = .navigationBarTintColor
    definesPresentationContext = true
    navigationItem.searchController = searchController
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    
  }
  
  func setupLayoutUI() {
    searchView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

// MARK: Setup UI
private extension SearchViewController {
  func makeSearchView() -> SearchView {
    let view = SearchView()
    return view
  }
}

// MARK: - UISearchControllerDelegate
extension SearchViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
      return
    }
    
    presenter.search(searchText: searchText)
  }
}

// MARK: - SearchViewInput
extension SearchViewController: SearchViewInput {
  func success(items: [MovieModel]) {
    hide()
    searchView.addMovie(items)
  }
  
  func failure(error: APIError) {
    hide()
    Alert.showAlert(on: self, with: .warning, message: error.localizedDescription)
  }
  
  func hideIndicator() {
    hide()
  }
  
  func showIndicator() {
    show()
  }
}

#if DEBUG
import SwiftUI

struct SearchViewRepresentable: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    return SearchViewController().view
  }
  func updateUIView(_ view: UIView, context: Context) {
    // do your logic here
  }
}

@available(iOS 13.0, *)
struct SearchViewController_Preview: PreviewProvider {
  static var previews: some View {
    SearchViewRepresentable()
  }
}
#endif
