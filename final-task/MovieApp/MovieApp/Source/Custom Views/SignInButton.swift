//
//  SignInButton.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

import UIKit.UIButton

final class SignInButton: UIButton {
  init() {
    super.init(frame: .zero)
    titleLabel?.font = .avenir(.fontL, .Medium)
    setTitleColor(.cellTitleColor, for: .normal)
    
    contentEdgeInsets = UIEdgeInsets(top: Constants.verticalEdgeInset,
                                     left: Constants.horizontalEdgeInset,
                                     bottom: Constants.verticalEdgeInset,
                                     right: Constants.horizontalEdgeInset)
    
    setTitleColor(.cellTitleColor.withAlphaComponent(0.2), for: .highlighted)
    setImage(UIImage(systemName: "person"), for: .normal)
    setImage(UIImage(systemName: "person.fill"), for: .highlighted)
    imageEdgeInsets.left = Constants.imageLeftInset
    tintColor = .cellTitleColor
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension SignInButton {
  private enum Constants {
    static let titleOpacity: CGFloat = 0.4
    static let imageLeftInset: CGFloat = -5
    static let backgroundOpacity: CGFloat = 0.2
    static let verticalEdgeInset: CGFloat = 10.0
    static let horizontalEdgeInset: CGFloat = 20.0
  }
}
