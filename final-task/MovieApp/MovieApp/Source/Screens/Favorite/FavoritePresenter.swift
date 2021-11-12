//
//  FavoritePresenter.swift
//  MovieApp
//
//  Created by rasul on 11/12/21.
//  
//

import Foundation

final class FavoritePresenter: FavoriteViewOutput {
	private let service: AccountAndListServiceProtocol
	weak var view: FavoriteViewInput?
		
	init(service: AccountAndListServiceProtocol, view: FavoriteViewInput) {
		self.service = service
		self.view = view
	}
}
