//
//  Coordinator.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

 protocol Coordinator: AnyObject {
  var children: [Coordinator] { get set }
  func start()
}

extension Coordinator {
  func addDependency(_ coordinator: Coordinator) {
    print("coordinator add vc")
    guard !children.contains(where: { $0 === coordinator }) else { return }
    children.append(coordinator)
  }
  
  func removeChildCoordinator(_ coordinator: Coordinator) {
    print("coordinator delete")
    for (index, coordinator) in children.enumerated()
    where coordinator === coordinator {
      children.remove(at: index)
        break
    }
  }
}
