//
//  UIControl+Extension.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

import UIKit.UIControl

extension UIControl {
  func off() {
      isEnabled = false
      alpha = 0.3
  }
  
  func on() {
      isEnabled = true
      alpha = 1.0
  }
}
