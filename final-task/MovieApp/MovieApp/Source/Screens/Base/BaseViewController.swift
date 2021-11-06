
import UIKit
import MBProgressHUD

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
  
  func show(_ message: String = "") {
    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
    hud.label.text = message
    hud.contentColor = .titleColor
    hud.label.textColor = .black
    hud.isUserInteractionEnabled = false
  }
  
  func hide() {
    MBProgressHUD.hide(for: self.view, animated: true)
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
