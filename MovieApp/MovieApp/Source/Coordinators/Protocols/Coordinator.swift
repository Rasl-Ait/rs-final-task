//
//  Coordinator.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

 protocol Coordinator: AnyObject {
   var childCoordinators: [Coordinator] { get }
  func start()
}

class BaseCoordinator: Coordinator {
  var childCoordinators: [Coordinator] = []
  
  func start() { }
  
  func addDependency(_ coordinator: Coordinator) {
      guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
      childCoordinators.append(coordinator)
  }
  
  func removeChildCoordinator(_ coordinator: Coordinator?) {
    guard
      childCoordinators.isEmpty == false,
      let coordinator = coordinator
      else { return }
    
    if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
        coordinator.childCoordinators
            .filter({ $0 !== coordinator })
            .forEach({ coordinator.removeChildCoordinator($0) })
    }
    
    for (index, element) in childCoordinators.enumerated() where element === coordinator {
        childCoordinators.remove(at: index)
        break
    }
  }
  
  func removeAllChildCoordinators() {
    childCoordinators.removeAll()
  }
}
