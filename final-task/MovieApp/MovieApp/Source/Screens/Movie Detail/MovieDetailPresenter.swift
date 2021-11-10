//
//  MovieDetailPresenter.swift
//  MovieApp
//
//  Created by rasul on 11/10/21.
//  
//

import Foundation

final class MovieDetailPresenter: MovieDetailViewOutput {
	private let service: MovieServiceProtocol
	weak var view: MovieDetailViewInput?
		
	init(
    service: MovieServiceProtocol,
    view: MovieDetailViewInput) {
		self.service = service
		self.view = view
	}
}
