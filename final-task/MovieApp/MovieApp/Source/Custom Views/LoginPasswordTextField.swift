//
//  LoginPasswordTextField.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

import UIKit.UITextField

final class LoginPasswordTextField: UITextField {
  
  private let insets = UIEdgeInsets(left: .marginL)
  
  var fieldType: TextFieldType = .login {
    didSet {
      switch fieldType {
      case .login:
        keyboardType = .emailAddress
        autocorrectionType = .no
        autocapitalizationType = .none
        isSecureTextEntry = false
        placeholder = TextType.login.rawValue.capitalized
      case .password:
        keyboardType = .asciiCapable
        autocorrectionType = .no
        autocapitalizationType = .none
        isSecureTextEntry = true
        placeholder = TextType.password.rawValue.capitalized
      }
    }
  }
  
  init() {
    super.init(frame: .zero)
    font = .avenir(.fontL, .Regular)
    backgroundColor = .cellBackground
    textColor = .titleColor
    tintColor = .titleColor
    keyboardType = .emailAddress
    autocorrectionType = .no
    autocapitalizationType = .none
    layer.cornerRadius = .radiusXS
    layer.borderColor = UIColor.lightGray.cgColor
    addShadow(ofColor: .black, radius: 3, offset: .zero, opacity: 0.15)
  }
  
  override var intrinsicContentSize: CGSize {
    let superContentSize = super.intrinsicContentSize
    let width = superContentSize.width
    let height = superContentSize.height
    return CGSize(width: width, height: height + .marginXXL)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: insets)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: insets)
  }
  
  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: insets)
  }
}
