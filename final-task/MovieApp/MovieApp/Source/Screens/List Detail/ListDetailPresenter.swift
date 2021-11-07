//
//  ListDetailPresenter.swift
//  MovieApp
//
//  Created by rasul on 11/7/21.
//  
//

import Foundation

final class ListDetailPresenter: ListDetailViewOutput {
  // MARK: - Properties
  private(set) var alertTitles = ["Date", "Popular", "Rate"]
  
	private let service: AccountAndListServiceProtocol
	weak var view: ListDetailViewInput?
  
  init(
    service: AccountAndListServiceProtocol,
    view: ListDetailViewInput) {
    self.service = service
    self.view = view
  }
}
