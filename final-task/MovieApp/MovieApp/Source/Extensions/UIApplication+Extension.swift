//
//  UIApplication.swift
//  SpaseX
//
//  Created by rasul on 9/23/21.
//

import UIKit

extension UIApplication {
  var keyWindowInConnectedScenes: UIWindow? {
    return windows.first(where: { $0.isKeyWindow })
  }
}
