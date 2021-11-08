//
//  ListDetailCoordinator.swift
//  MovieApp
//
//  Created by rasul on 11/7/21.
//

import UIKit

protocol ListDetailCoordinatorProtocol: AnyObject {
  func pop()
}

final class ListDetailCoordinator: Coordinator {
  let router: Router
  let screenFactory: ScreenFactory
  let list: ListModel
  
  var finishFlow: VoidClosure?
  
  init(router: Router, screenFactory: ScreenFactory, list: ListModel) {
    self.router = router
    self.screenFactory = screenFactory
    self.list = list
  }
  
  func start() {
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
    finishFlow?()
  }
}
