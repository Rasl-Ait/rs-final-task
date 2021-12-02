
import UIKit

extension UIViewController {
	
  func add(childVC: UIViewController) {
    childVC.view.disableAutoresizingMask()
    addChild(childVC)
    view.addSubview(childVC.view)
    childVC.didMove(toParent: self)
    NSLayoutConstraint.activate([
      childVC.view.topAnchor.constraint(equalTo: view.topAnchor),
      childVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      childVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      childVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
  
  func remove(childVC: UIViewController?) {
    childVC?.willMove(toParent: nil)
    childVC?.view.removeFromSuperview()
    childVC?.removeFromParent()
  }
	
  func present(_ vc: UIViewController) {
    let navVC = UINavigationController(rootViewController: vc)
    navVC.modalPresentationStyle = .currentContext
    present(navVC, animated: true, completion: nil)
  }
}
