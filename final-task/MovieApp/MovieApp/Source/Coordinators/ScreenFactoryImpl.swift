//
//  ScreenFactory.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

import Foundation

final class ScreenFactoryImpl: ScreenFactory {
  func makeAuthScreen(_ coordinator: AuthCoordinatorProtocol) -> AuthViewController {
    let vc = AuthViewController()
    let service = AuthService(client: NetworkService())
    let presenter = AuthPresenter(service: service, view: vc)
    presenter.coordinator = coordinator
    vc.presenter = presenter
    return vc
  }
  
  func makeListsScreen(_ coordinator: ListsCoordinatorProtocol) -> ListsViewController {
    let vc = ListsViewController()
    let service = AccountService(client: NetworkService())
    let presenter = ListsPresenter(view: vc, service: service)
    presenter.coordinator = coordinator
    vc.presenter = presenter
    return vc
  }
}
