
import UIKit

class BaseViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  func configureNavigationBar(isHidden: Bool, barStyle: UIBarStyle) {
    navigationController?.navigationBar.isHidden = isHidden
    navigationController?.navigationBar.barStyle = barStyle
  }
  
  func addTapGesture() {
    let tapGesture = UITapGestureRecognizer(
      target: self,
      action: #selector(hideKeyboard)
    )
    view.addGestureRecognizer(tapGesture)
  }
  
  @objc func hideKeyboard() {
    self.view.endEditing(true)
  }  
}
