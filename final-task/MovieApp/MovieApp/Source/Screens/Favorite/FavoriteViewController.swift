//
//  FavoriteViewController.swift
//  MovieApp
//
//  Created by rasul on 11/12/21.
//  
//

import UIKit

final class FavoriteViewController: BaseViewController {
  
  // MARK: - Properties
  private lazy var favoriteView = makeFavoriteView()
	var presenter: FavoriteViewOutput!
    
	override func viewDidLoad() {
		super.viewDidLoad()
    setupViews()
	}
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.getFavoriteMovie()
  }
}

// MARK: - Private Extension
private extension FavoriteViewController {
  func setupViews() {
    configureNavigationBar()
    setupAppearence()
    setupLayoutUI()    
    closure()
  }
  
  func setupAppearence() {
    view.addSubview(favoriteView)
  }

  func setupLayoutUI() {
    favoriteView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  func configureNavigationBar() {
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.title = "Favorite"
  }
  
  func closure() {
    favoriteView.didSelect = { [weak self] type in
      guard let self = self else { return }
      self.presenter.didSelect(type: type)
    }
  }
}

// MARK: Setup UI
private extension FavoriteViewController {
  func makeFavoriteView() -> FavoriteView {
    let view = FavoriteView()
    return view
  }
}

// MARK: FavoriteViewInput
extension FavoriteViewController: FavoriteViewInput {
  func success(items: [MovieModel]) {
    hide()
    favoriteView.addMovie(items)
  }
  
  func successDeleteMovie() {
    favoriteView.removeFavorite()
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
