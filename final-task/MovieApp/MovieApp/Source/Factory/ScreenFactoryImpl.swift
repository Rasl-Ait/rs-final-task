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
    let config = URLSessionConfiguration.default
    config.requestCachePolicy = .reloadIgnoringLocalCacheData
    config.urlCache = nil
    config.httpAdditionalHeaders = ["Content-Type": "application/json",
                                    "Accept": "application/json",
                                    "Authorization": "Bearer \(Constant.token)"]
    let urlSession = URLSession(configuration: config)
    let service = AuthService(client: NetworkService(session: urlSession))
    let presenter = AuthPresenter(service: service, view: vc)
    presenter.coordinator = coordinator
   vc.presenter = presenter
    return vc
  }
  
  func makeListsScreen(_ coordinator: ListsCoordinatorProtocol, mediaID: Int?) -> ListsViewController {
    let vc = ListsViewController()
    let config = URLSessionConfiguration.default
    config.requestCachePolicy = .reloadIgnoringLocalCacheData
    config.urlCache = nil
    config.httpAdditionalHeaders = ["Content-Type": "application/json",
                                    "Accept": "application/json",
                                    "Authorization": "Bearer \(Constant.token)"]
    let urlSession = URLSession(configuration: config)
    let service = AccountAndListService(client: NetworkService(session: urlSession))
    let serviceAuth = AuthService(client: NetworkService(session: urlSession))
    let coreDataTask = (UIApplication.shared.delegate as? AppDelegate)?.coreDataTask
    let persistence = MoviePersistence(context: coreDataTask!.managedContext,
                                       backgroundContext: coreDataTask!.backgroundContext)
    let presenter = ListsPresenter(view: vc,
                                   service: service,
                                   persistence: persistence,
                                   mediaID: mediaID,
                                   serviceAuth: serviceAuth)
    presenter.coordinator = coordinator
    vc.presenter = presenter
    return vc
  }
  
  func makeListDetailScreen(_ coordinator: ListDetailCoordinatorProtocol, list: ListModel) -> ListDetailViewController {
    let vc = ListDetailViewController()
    let config = URLSessionConfiguration.default
    config.requestCachePolicy = .reloadIgnoringLocalCacheData
    config.urlCache = nil
    config.httpAdditionalHeaders = ["Content-Type": "application/json",
                                    "Accept": "application/json",
                                    "Authorization": "Bearer \(Constant.token)"]
    let urlSession = URLSession(configuration: config)
    let service = AccountAndListService(client: NetworkService(session: urlSession))
    let coreDataTask = (UIApplication.shared.delegate as? AppDelegate)?.coreDataTask
    let persistence = MoviePersistence(context: coreDataTask!.managedContext,
                                       backgroundContext: coreDataTask!.backgroundContext)
    let presenter = ListDetailPresenter(
      view: vc,
      service: service,
      list: list,
      persistence: persistence
    )
    presenter.coordinator = coordinator
    vc.presenter = presenter
    return vc
  }
  
  func makeMovieDetailScreen(_ coordinator: MovieDetailCoordinatorProtocol, id: Int) -> MovieDetailViewController {
    let vc = MovieDetailViewController()
    let config = URLSessionConfiguration.default
    config.requestCachePolicy = .reloadIgnoringLocalCacheData
    config.urlCache = nil
    config.httpAdditionalHeaders = ["Content-Type": "application/json",
                                    "Accept": "application/json",
                                    "Authorization": "Bearer \(Constant.token)"]
    let urlSession = URLSession(configuration: config)
    let service = MovieService(client: NetworkService(session: urlSession))
    
    let serviceAccount = AccountAndListService(client: NetworkService(session: urlSession))
    let presenter = MovieDetailPresenter(
      service: service,
      serviceAccount: serviceAccount,
      view: vc,
      movieId: id
    )
    presenter.coordinator = coordinator
    vc.presenter = presenter
    return vc
  }
  
  func makeWebViewScreen(_ coordinator: MovieDetailCoordinatorProtocol, stringURL: String) -> WebViewController {
    let view = WebViewController()
    view.stringURL = stringURL
    return view
  }
  
  func makeSearchScreen(_ coordinator: SearchCoordinatorProtocol) -> SearchViewController {
    let viewController = SearchViewController()
    let config = URLSessionConfiguration.default
    config.requestCachePolicy = .reloadIgnoringLocalCacheData
    config.urlCache = nil
    config.httpAdditionalHeaders = ["Content-Type": "application/json",
                                    "Accept": "application/json",
                                    "Authorization": "Bearer \(Constant.token)"]
    let service = SearchService(client: NetworkService(session: URLSession(configuration: config)))
    let presenter = SearchPresenter(service: service, view: viewController)
    presenter.coordinator = coordinator
    viewController.presenter = presenter
    return viewController
  }
  
  func makeFavoriteScreen(_ coordinator: FavoriteCoordinatorProtocol) -> FavoriteViewController {
    let viewController = FavoriteViewController()
    let config = URLSessionConfiguration.default
    config.requestCachePolicy = .reloadIgnoringLocalCacheData
    config.urlCache = nil
    config.httpAdditionalHeaders = ["Content-Type": "application/json",
                                    "Accept": "application/json",
                                    "Authorization": "Bearer \(Constant.token)"]
    let service = AccountAndListService(client: NetworkService(session: URLSession(configuration: config)))
    let coreDataTask = (UIApplication.shared.delegate as? AppDelegate)?.coreDataTask
    let persistence = MoviePersistence(context: coreDataTask!.managedContext,
                                       backgroundContext: coreDataTask!.backgroundContext)
    let presenter = FavoritePresenter(
      service: service,
      view: viewController,
      persistence: persistence
    )
    presenter.coordinator = coordinator
    viewController.presenter = presenter
    return viewController
  }
}
