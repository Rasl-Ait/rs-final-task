
import UIKit

struct Alert {
  static func showAlertSheet(
    on vc: UIViewController,
    title: String,
    titles: [String],
    tapAction: ((UIAlertAction) -> Void)? = nil) {
    
    let alert = UIAlertController(
      title: title,
      message: "",
      preferredStyle: .actionSheet)
  //  alert.view.tintColor = .queenBlue
  
    titles.forEach {
      let action = UIAlertAction(title: $0, style: .default, handler: tapAction)
     // action.setValue(UIColor.coral, forKey: "titleTextColor")
      alert.addAction(action)
    }
    
    let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
  //  actionCancel.setValue(UIColor.customRed, forKey: "titleTextColor")
  
    alert.addAction(actionCancel)
    DispatchQueue.main.async {
      vc.present(alert, animated: true, completion: nil)
    }
  }
  
  static func showAlert(
    on vc: UIViewController,
    with title: AlertTitleType,
    message: String) {
    let alert = UIAlertController(title: title.rawValue, message: message, preferredStyle: .alert)
    //  alert.view.tintColor = .queenBlue
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    DispatchQueue.main.async { vc.present(alert, animated: true, completion: nil) }
  }
  
  static func showAlertAction(
    on vc: UIViewController,
    title: AlertTitleType,
    message: AlertMessageType = .none,
    primaryTitle: AlertButton = .yes,
    secondTitle: String = "Cancel",
    preferredStyle: UIAlertController.Style = .alert,
    primaryAction: ((UIAlertAction) -> Void)? = nil,
    secondAction: ((UIAlertAction) -> Void)? = nil) {
    
    let alert = UIAlertController(
      title: title.rawValue,
      message: message.rawValue,
      preferredStyle: preferredStyle)
    let action = UIAlertAction(title: primaryTitle.rawValue, style: .default, handler: primaryAction)
    
    let actionCancel = UIAlertAction(title: secondTitle, style: .default, handler: secondAction)
  //  action.setValue(UIColor.red, forKey: "titleTextColor")
    alert.addAction(actionCancel)
    alert.addAction(action)
    DispatchQueue.main.async {
      vc.present(alert, animated: true, completion: nil)
    }
  }
  
  static func showAlertText(
    on vc: UIViewController,
    title: AlertTitleType,
    text: AlertMessageType = .none,
    primaryTitle: AlertButton = .yes,
    secondTitle: AlertButton = .cancel,
    placeholder: String? = nil,
    editingChangedTarget: Any?,
    editingChangedSelector: Selector?,
    primaryAction: ((UIAlertAction) -> Void)?,
    secondAction: ((UIAlertAction) -> Void)?) {
    let alert = UIAlertController(title: title.rawValue, message: text.rawValue, preferredStyle: .alert)
    alert.addTextField { textField in
      textField.placeholder = placeholder
      if let target = editingChangedTarget, let selector = editingChangedSelector {
        textField.addTarget(target, action: selector, for: .editingChanged)
      }
    }
    
    let action = UIAlertAction(title: primaryTitle.rawValue, style: .default, handler: primaryAction)
    
    let actionCancel = UIAlertAction(title: secondTitle.rawValue, style: .default, handler: secondAction)
  //  action.setValue(UIColor.red, forKey: "titleTextColor")
    alert.addAction(actionCancel)
    alert.addAction(action)
    DispatchQueue.main.async {
      vc.present(alert, animated: true, completion: nil)
    }
  }
}
