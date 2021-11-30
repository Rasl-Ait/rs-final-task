//
//  MovieDetailCoordinator.swift
//  MovieApp
//
//  Created by rasul on 11/12/21.
//

import Foundation

/// @mockable
protocol MovieDetailCoordinatorProtocol: AnyObject {
  func pop()
  func pushWebViewVC(stringURL: String)
  func pushList(mediaID: Int)
  var finishFlow: VoidClosure? { get set }
}

final class MovieDetailCoordinator: BaseCoordinator, MovieDetailCoordinatorProtocol {
  private let router: Router
  private let coordinatorFactory: CoordinatorFactory
  private let screenFactory: ScreenFactory
  private let movieID: Int
  
  var finishFlow: VoidClosure?
  
  init(
    router: Router,
    coordinatorFactory: CoordinatorFactory,
    screenFactory: ScreenFactory,
    movieID: Int) {
    self.router = router
    self.screenFactory = screenFactory
    self.coordinatorFactory = coordinatorFactory
    self.movieID = movieID
  }
  
  override func start() {
    pushMovieDetail()
  }
}

// MARK: - MovieDetailCoordinator
extension MovieDetailCoordinator {
  func pushMovieDetail() {
    let viewController = screenFactory.makeMovieDetailScreen(self, id: movieID)
    router.push(viewController, hideBottomBar: true)
  }
  
  func pop() {
    router.popModule()
    finishFlow?()
  }
  
  func pushWebViewVC(stringURL: String) {
    let viewController = screenFactory.makeWebViewScreen(self, stringURL: stringURL)
    router.push(viewController)
  }
  
  func pushList(mediaID: Int) {
    let listCoordinator = coordinatorFactory.makeListsCoordinator(
      router: router
    )
    
    listCoordinator.finishFlow = { [weak self, weak listCoordinator] in
      guard let self = self else { return }
      self.removeChildCoordinator(listCoordinator)
    }
    
    listCoordinator.mediaID = mediaID
    listCoordinator.screenType = .movieDetail
    addDependency(listCoordinator)
    listCoordinator.start()
  }
}
