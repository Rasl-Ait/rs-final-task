//
//  ViewController.swift
//  MovieApp
//
//  Created by rasul on 10/27/21.
//

import UIKit

final class AuthViewController: BaseViewController {
  
  // MARK: - Properties
  private lazy var scrollView = makeScrollView()
  private lazy var authView = makeAuthView()
  
  var presenter: AuthViewOutput!
  
  // MARK: - Overriden funcs
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    configureNavigationBar(isHidden: true, barStyle: .default)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(
      self,
      name: UIResponder.keyboardWillShowNotification,
      object: nil
    )
    NotificationCenter.default.removeObserver(
      self,
      name: UIResponder.keyboardWillChangeFrameNotification,
      object: nil
    )
  }
}

// MARK: - Private Extension
private extension AuthViewController {
  func setupViews() {
    view.backgroundColor = .background
    apperance()
    setupLayoutUI()
    notificaton()
    addTapGesture()
    
    authView.didSignInSelect = { [weak self] param in
      guard let self = self else { return }
      self.presenter.newToken(param)
    }
  }
  
  func apperance() {
    scrollView.addSubview(authView)
    view.addSubview(scrollView)
  }
  
  func notificaton() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillShowHide(notification:)),
      name: UIResponder.keyboardWillShowNotification, object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillShowHide(notification:)),
      name: UIResponder.keyboardWillHideNotification, object: nil
    )
  }
  
  func setupLayoutUI() {
    scrollView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    authView.snp.makeConstraints {
      $0.edges.equalTo(scrollView)
      $0.width.equalTo(view)
      $0.height.equalToSuperview()
    }
  }
  
  @objc func keyboardWillShowHide(notification: Notification) {
    guard let userInfo = notification.userInfo else { return }
    let safeAreaBottom = view.safeAreaInsets.bottom + 10
    if let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
      let keyboardViewEndFrame = view.convert(keyboardSize, from: view.window)
      let keyboardDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
      if notification.name == UIResponder.keyboardWillHideNotification {
        updateBottonConstraints(cons: .zero, duration: keyboardDuration ?? 0.0)
      } else {
        if #available(iOS 11.0, *) {
          let cons = UIEdgeInsets(bottom: keyboardViewEndFrame.height + safeAreaBottom + 40)
          updateBottonConstraints(cons: cons, duration: keyboardDuration ?? 0.0)
        } else {
          let cons = UIEdgeInsets(bottom: keyboardViewEndFrame.height)
          updateBottonConstraints(cons: cons, duration: keyboardDuration ?? 0.0)
        }
      }
    }
  }
  
  func updateBottonConstraints(cons: UIEdgeInsets, duration: Double) {
    scrollView.contentInset = cons
    UIView.animate(withDuration: duration) {
      self.view.layoutIfNeeded()
    }
  }
}

// MARK: - Setup UI
private extension AuthViewController {
  func makeAuthView() -> AuthView {
    let view = AuthView()
    return view
  }
  
  func makeScrollView() -> UIScrollView {
    let view = UIScrollView()
    view.keyboardDismissMode = .onDrag
    view.showsVerticalScrollIndicator = false
    return view
  }
}

// MARK: - AuthViewInput
extension AuthViewController: AuthViewInput {
  func success() {
    hide()
  }
  
  func failure(error: Error) {
    hide()
    Alert.showAlert(on: self, with: .attention, message: error.localizedDescription)
  }
  
  func hideIndicator() {
    hide()
  }
  
  func showIndicator() {
    show()
  }
}

#if DEBUG
import SwiftUI

struct AuthViewControllerRepresentable: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    return AuthViewController().view
  }
  func updateUIView(_ view: UIView, context: Context) {
    // do your logic here
  }
}

@available(iOS 13.0, *)
struct AuthViewController_Preview: PreviewProvider {
  static var previews: some View {
    AuthViewControllerRepresentable()
  }
}
#endif
