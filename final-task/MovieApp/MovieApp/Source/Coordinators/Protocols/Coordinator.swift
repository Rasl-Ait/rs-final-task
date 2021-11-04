//
//  Coordinator.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

 protocol Coordinator: AnyObject {

  var children: [Coordinator] { get set }
  var router: Router { get }

  func present(animated: Bool, onDismissed: (() -> Void)?)
  func dismiss(animated: Bool)
  func presentChild(_ child: Coordinator,
                    animated: Bool,
                    onDismissed: (() -> Void)?)
}

extension Coordinator {
   func dismiss(animated: Bool) {
    router.dismiss(animated: true)
  }

  public func presentChild(_ child: Coordinator,
                           animated: Bool,
                           onDismissed: (() -> Void)? = nil) {
    print("coordinator add")
    children.append(child)
    child.present(animated: animated, onDismissed: { [weak self, weak child] in
      guard let self = self, let child = child else { return }
      self.removeChild(child)
      onDismissed?()
    })
  }

  private func removeChild(_ child: Coordinator) {
    print("coordinator delete")
    guard let index = children.firstIndex(where: { $0 === child })
      else {
        return
    }
    children.remove(at: index)
  }
}
