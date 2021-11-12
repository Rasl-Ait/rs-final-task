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
		
	init(service: SearchServiceProtocol, view: SearchViewInput) {
		self.service = service
		self.view = view
	}
}
