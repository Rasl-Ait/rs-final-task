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
	
	init(view: ListsViewInput) {
		self.view = view
	}
}
