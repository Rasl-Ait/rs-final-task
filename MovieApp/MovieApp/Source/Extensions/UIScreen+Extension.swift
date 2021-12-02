//
//  UIScreen.swift
//  Wallets
//
//  Created by rasul on 9/29/21.
//

import UIKit

extension UIScreen {
  static var width: CGFloat {
    return bounds().width
  }
  
  static var height: CGFloat {
    return bounds().height
  }
  
  static var halfHeight: CGFloat {
    return height / 2
  }
  
  static func bounds() -> CGRect {
    return self.main.bounds
  }
  
  static var size: CGSize {
    return self.bounds().size
  }
}
