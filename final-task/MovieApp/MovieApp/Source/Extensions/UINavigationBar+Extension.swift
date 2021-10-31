//
//  UINavigationBar+Extension.swift
//  GameCounter
//
//  Created by rasul on 8/25/21.
//

import UIKit

public extension UINavigationBar {
    func setTitleFont(_ font: UIFont, color: UIColor = .black) {
        var attrs = [NSAttributedString.Key: Any]()
        attrs[.font] = font
        attrs[.foregroundColor] = color
        titleTextAttributes = attrs
    }
  
  func setLargeTitleFont(_ font: UIFont, color: UIColor = .black) {
      var attrs = [NSAttributedString.Key: Any]()
      attrs[.font] = font
      attrs[.foregroundColor] = color
      largeTitleTextAttributes = attrs
  }

    func makeTransparent(withTint tint: UIColor = .white) {
        isTranslucent = true
        backgroundColor = .clear
        barTintColor = .clear
        setBackgroundImage(UIImage(), for: .default)
        tintColor = tint
        titleTextAttributes = [.foregroundColor: tint]
        shadowImage = UIImage()
    }
  
    func setColors(background: UIColor, text: UIColor) {
        isTranslucent = false
        backgroundColor = background
        barTintColor = background
        setBackgroundImage(UIImage(), for: .default)
        tintColor = text
        titleTextAttributes = [.foregroundColor: text]
    }
}
