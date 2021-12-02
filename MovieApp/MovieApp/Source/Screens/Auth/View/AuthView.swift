//
//  AuthView.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

import UIKit
import SnapKit

final class AuthView: UIView {
  
  // MARK: - Properties
  private lazy var logoView = makeLogoView()
  private lazy var imageView = makeImageView()
  private lazy var loginTextField = makeLoginTextField()
  private lazy var passwordTextField = makePasswordTextField()
  private lazy var stackView = makeStackView()
  private lazy var signInButton = makeSignInButton()
  
  private let empty = ""
  
  // MARK: Closure
  var didSignInSelect: ItemClosure<AuthParam>?
  
  // MARK: Overriden funcs
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Private Extension
private extension AuthView {
  func setupView() {
    backgroundColor = .backgroundColor
    setupAppearence()
    setupLayoutUI()
  }
  
  func setupAppearence() {
    logoView.addSubview(imageView)
    addSubview(logoView)
    addSubview(stackView)
    addSubview(signInButton)
  }
  
  func setupLayoutUI() {
    imageView.snp.makeConstraints {
      $0.width.equalTo(Size.imageWidth)
      $0.height.equalTo(Size.imageHeight)
      $0.center.equalToSuperview()
    }
    
    logoView.snp.makeConstraints {
      $0.top.equalTo(safeAreaLayoutGuide).offset(Constants.logoTop)
      $0.width.equalTo(Size.logoWidth)
      $0.height.equalTo(Size.logoHeight)
      $0.centerX.equalToSuperview()
    }
        
    stackView.snp.makeConstraints {
      $0.centerY.equalToSuperview().offset(Constants.stackViewTop)
      $0.leading.trailing.equalToSuperview().inset(Constants.stackViewLeftRight)
    }
    
    signInButton.snp.makeConstraints {
      $0.top.equalTo(stackView.snp.bottom).offset(Constants.logoTop)
      $0.leading.trailing.equalTo(stackView)
      $0.height.equalTo(loginTextField)
    }
  }
}

// MARK: - Setup UI
private extension AuthView {
  func makeLogoView() -> UIView {
    let view = UIView()
    view.backgroundColor = .logoBackgroundColor
    view.layer.cornerRadius = CornerRadius.logoViewRadius
    view.addShadow()
    return view
  }
  
  func makeImageView() -> UIImageView {
    let imageView = UIImageView(
      .setImage(.logo),
      contentMode: .scaleAspectFit
    )
    return imageView
  }
  
  func makeLoginTextField() -> LoginPasswordTextField {
    let view = LoginPasswordTextField()
    view.fieldType = .login
    view.delegate = self
    return view
  }
  
  func makePasswordTextField() -> LoginPasswordTextField {
    let view = LoginPasswordTextField()
    view.fieldType = .password
    view.delegate = self
    return view
  }
  
  func makeStackView() -> CustomStackView {
    let view = CustomStackView(axis: .vertical, spacing: Spacing.stackView)
    view.distribution = .fillEqually
    view.addArrangedSubview(loginTextField)
    view.addArrangedSubview(passwordTextField)
    return view
  }
  
  func makeSignInButton() -> SignInButton {
    let button = SignInButton()
    button.setTitle(TextType.signIn.rawValue.capitalized, for: .normal)
    button.addTarget(
      self,
      action: #selector(buttonTapped),
      for: .touchUpInside
    )
      return button
  }
}

// MARK: Action
private extension AuthView {
  @objc func buttonTapped() {
    let isLogin: Bool = loginTextField.text != empty
    let isPassword: Bool = passwordTextField.text != empty
    
    loginTextField.updateState(isLogin ? .success : .failure)
    passwordTextField.updateState(isPassword ? .success : .failure)
    
    if isLogin, isPassword {
      guard
          let login = loginTextField.text,
          let password = passwordTextField.text
        else {
          return
        }
        let param = AuthParam(username: login, password: password)
        didSignInSelect?(param)
    }
  }
}

extension AuthView: UITextFieldDelegate {
  func textFieldDidChangeSelection(_ textField: UITextField) {
      if let textField = (textField as? LoginPasswordTextField),
         textField.selectedState == .failure {
          textField.updateState(.default)
      }
  }
  func textFieldDidBeginEditing(_ textField: UITextField) {
      (textField as? LoginPasswordTextField)?
        .updateState(.default)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}

// MARK: - Constants
extension AuthView {
  private enum Constants {
    static let logoTop: CGFloat = .marginXXXL
    static let stackViewLeftRight: CGFloat = .marginL
    static let stackViewTop: CGFloat = .marginL
  }
  
  private enum Size {
    static let imageWidth: CGFloat = 185.0
    static let imageHeight: CGFloat = 134.0
    static let logoWidth: CGFloat = 306.0
    static let logoHeight: CGFloat = 200.0
    static let loginPasswordHeighWidth: CGFloat = 57
  }
  
  private enum CornerRadius {
    static let logoViewRadius: CGFloat = .radiusXXXL
  }
  
  private enum Spacing {
    static let stackView: CGFloat = .spacingL
  }
}

#if DEBUG
import SwiftUI

struct AuthViewRepresentable: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    return AuthViewController().view
  }
  func updateUIView(_ view: UIView, context: Context) {
    // do your logic here
  }
}

@available(iOS 13.0, *)
struct AuthView_Preview: PreviewProvider {
  static var previews: some View {
    AuthViewRepresentable()
  }
}
#endif
