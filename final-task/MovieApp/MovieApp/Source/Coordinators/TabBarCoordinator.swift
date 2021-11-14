//
//  TabBarCoordinator.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//

import UIKit

final class TabBarCoordinator: BaseCoordinator {
  private let router: Router
  private let coordinatorFactory: CoordinatorFactory
  private let screenFactory: ScreenFactory
  
  var finishFlow: VoidClosure?
  
  init(router: Router,
       screenFactory: ScreenFactory,
       coordinatorFactory: CoordinatorFactory) {
    self.router = router
    self.screenFactory = screenFactory
    self.coordinatorFactory = coordinatorFactory
  }
  
  override func start() {
    pushTabBar()
  }
}

extension TabBarCoordinator {
   func pushTabBar() {
    let tabBarController = TabBarController()
    let listCoordinator = coordinatorFactory.makeListsCoordinator(
      router: router,
      tabBarViewController: tabBarController)
    
    listCoordinator.finishFlow = { [weak self] in
      guard let self = self else { return }
      self.finishFlow?()
    }
    
    let searchCoordinator = coordinatorFactory.makeSearchCoordinator(router: router,
                                                                     tabBarViewController: tabBarController)
    let favoriteCoordinator = coordinatorFactory.makeFavoriteCoordinator(router: router,
                                                                         tabBarViewController: tabBarController)
    
    addDependency(listCoordinator)
    addDependency(searchCoordinator)
    addDependency(favoriteCoordinator)
    listCoordinator.start()
    searchCoordinator.start()
    favoriteCoordinator.start()
   router.setRootModule(tabBarController, hideBar: false)
  }
}
