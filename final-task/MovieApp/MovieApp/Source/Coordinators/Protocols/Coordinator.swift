//
//  Coordinator.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

 protocol Coordinator: AnyObject {
  func start()
}

class BaseCoordinator: Coordinator {
  var childCoordinators: [Coordinator] = []
  
  func start() {
    
  }
  func addDependency(_ coordinator: Coordinator) {
    print("до \(childCoordinators.count)")
    print("coordinator add vc")
    guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
    childCoordinators.append(coordinator)
    print("после \(childCoordinators.count)")
  }
  
  func removeChildCoordinator(_ coordinator: Coordinator?) {
    print("delete до \(childCoordinators.count)")
    print("coordinator delete")
    for (index, coordinator) in childCoordinators.enumerated()
    where coordinator === coordinator {
      childCoordinators.remove(at: index)
        break
    }
    
    print("delete после \(childCoordinators.count)")
  }
}
