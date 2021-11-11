//
//  ListDetailCoordinator.swift
//  MovieApp
//
//  Created by rasul on 11/7/21.
//

import UIKit

protocol ListDetailCoordinatorProtocol: AnyObject {
  func pop()
  func dissmiss()
  func pushMovieDetailVC(id: Int)
  func pushWebViewVC(stringURL: String)
  func pushList(mediaID: Int)
}

final class ListDetailCoordinator: BaseCoordinator {
  let router: Router
  let coordinatorFactory: CoordinatorFactory
  let screenFactory: ScreenFactory
  let list: ListModel
  
  var finishFlow: VoidClosure?
  
  init(router: Router, coordinatorFactory: CoordinatorFactory, screenFactory: ScreenFactory, list: ListModel) {
    self.router = router
    self.screenFactory = screenFactory
    self.list = list
    self.coordinatorFactory = coordinatorFactory
  }
  
  override func start() {
    pushListDetail()
  }
  
  deinit {
    print("delete coordinator List detail")
  }
}

// MARK: - ListDetailCoordinator
extension ListDetailCoordinator: ListDetailCoordinatorProtocol {
   func pushListDetail() {
    let viewController = screenFactory.makeListDetailScreen(self, list: list)
    router.push(viewController)
  }
  
  func pop() {
    router.popModule()
    finishFlow?()
  }
  
  func pushMovieDetailVC(id: Int) {
    let viewController = screenFactory.makeMovieDetailScreen(self, id: id)
    router.push(viewController)
  }
  
  func pushWebViewVC(stringURL: String) {
    let viewController = screenFactory.makeWebViewScreen(self, stringURL: stringURL)
    router.push(viewController)
  }
  
  func pushList(mediaID: Int) {
    let listCoordinator = coordinatorFactory.makeListsCoordinator(
      router: router,
      tabBarViewController: TabBarController()
    )
    listCoordinator.mediaID = mediaID
    listCoordinator.screenType = .movieDetail
    addDependency(listCoordinator)
    listCoordinator.start()
  }
  
  func dissmiss() {
    router.popModule()
  }
}
