//
//  SearchViewController.swift
//  MovieApp
//
//  Created by rasul on 11/12/21.
//  
//

import UIKit

final class SearchViewController: UIViewController {
	var presenter: SearchViewOutput!
    
	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension SearchViewController: SearchViewInput {
	func success() {}
	func failure(error: APIError) {}
	func hideIndicator() {}
	func showIndicator() {}
}
