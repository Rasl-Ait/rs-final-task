//
//  ScreenFactory.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

import UIKit

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
    let service = AccountAndListService(client: NetworkService())
 let coreDataTask = (UIApplication.shared.delegate as? AppDelegate)?.coreDataTask
    let persistence = MoviePersistence(context: coreDataTask!.managedContext, backgroundContext: coreDataTask!.backgroundContext)
    let presenter = ListsPresenter(view: vc, service: service, persistence: persistence)
    presenter.coordinator = coordinator
    vc.presenter = presenter
    return vc
  }
  
  func makeListDetailScreen(_ coordinator: ListDetailCoordinatorProtocol, list: ListModel) -> ListDetailViewController {
    let vc = ListDetailViewController()
    let service = AccountAndListService(client: NetworkService())
// let coreDataTask = (UIApplication.shared.delegate as? AppDelegate)?.coreDataTask
    // let persistence = MoviePersistence(context: coreDataTask!.managedContext, backgroundContext: coreDataTask!.backgroundContext)
    let presenter = ListDetailPresenter(view: vc, service: service, list: list)
    presenter.coordinator = coordinator
    vc.presenter = presenter
    return vc
  }
}
