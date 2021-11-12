//
//  FavoriteViewController.swift
//  MovieApp
//
//  Created by rasul on 11/12/21.
//  
//

import UIKit

final class FavoriteViewController: UIViewController {
	var presenter: FavoriteViewOutput!
    
	override func viewDidLoad() {
		super.viewDidLoad()
    setupViews()
	}
}

// MARK: - Private Extension
private extension FavoriteViewController {
  func setupViews() {
  }
}

// MARK: FavoriteViewInput
extension FavoriteViewController: FavoriteViewInput {
	func success() {}
	func failure(error: APIError) {}
	func hideIndicator() {}
	func showIndicator() {}
}
