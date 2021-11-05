//
//  ListsViewController.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//  
//

import UIKit

final class ListsViewController: BaseViewController {
	var presenter: ListsViewOutput!
    
	override func viewDidLoad() {
		super.viewDidLoad()
    view.backgroundColor = .background
    navigationItem.title = "Lists"
	}
}

extension ListsViewController: ListsViewInput {
	func success() {}
	func failure(error: Error) {}
	func hideIndicator() {}
	func showIndicator() {}
}
