//
//  LoginPasswordTextField.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

import UIKit.UITextField

final class LoginPasswordTextField: UITextField {
  
  enum State {
      case failure
      case success
      case `default`
  }
  
  var selectedState: State = .default
  
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
    backgroundColor = .cellBackgroundColor
    textColor = .cellTitleColor
    tintColor = .cellTitleColor
    keyboardType = .emailAddress
    autocorrectionType = .no
    autocapitalizationType = .none
    layer.cornerRadius = .radiusXS
    addShadow()
  }
  
  override var intrinsicContentSize: CGSize {
    let superContentSize = super.intrinsicContentSize
    let width = superContentSize.width
    let height = superContentSize.height
    return CGSize(width: width, height: height + .marginXXL)
  }
  
  func updateState(_ state: State) {
    switch state {
    case .success:
      layer.borderColor = UIColor.green.cgColor
      layer.borderWidth = 0.4
      
    case .failure:
      layer.borderColor = UIColor.red.cgColor
      layer.borderWidth = 0.4
    case .default:
      layer.borderColor = UIColor.lightGray.cgColor
      layer.borderWidth = 0.0
      text = nil
    }
    selectedState = state
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
