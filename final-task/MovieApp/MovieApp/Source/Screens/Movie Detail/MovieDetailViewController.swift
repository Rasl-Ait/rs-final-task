//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by rasul on 11/10/21.
//  
//

import UIKit

final class MovieDetailViewController: BaseViewController {
	var presenter: MovieDetailViewOutput!
    
	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

// MARK: - Private Extension
extension MovieDetailViewController: MovieDetailViewInput {
	func success() {}
	func failure(error: Error) {}
	func hideIndicator() {}
	func showIndicator() {}
}
