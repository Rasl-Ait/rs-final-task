//
//  NavigationController.swift
//  MovieApp
//
//  Created by rasul on 11/9/21.
//

import UIKit

final class NavigationController: UINavigationController {
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationBar.setTitleFont(.avenir(.fontML, .Bold), color: UIColor.navigationBarTitleColor)
    navigationBar.setLargeTitleFont(.avenir(.fontXXXL, .Bold), color: UIColor.navigationBarTitleColor)
    navigationBar.barTintColor = UIColor.navigationBarBarTintColor
    navigationBar.tintColor = UIColor.navigationBarTintColor
    navigationBar.isTranslucent = true
    view.backgroundColor = UIColor.navigationBarBarTintColor
    
    var attrs3 = [NSAttributedString.Key: Any]()
    attrs3[.foregroundColor] = UIColor.navigationBarBarTintColor.withAlphaComponent(0.5)
    
    UINavigationBar.appearance().backIndicatorImage = .setImage(.back)
      UINavigationBar.appearance().backIndicatorTransitionMaskImage = .setImage(.back)
    
    UIBarButtonItem.appearance().setTitleTextAttributes(attrs3, for: .disabled)
    UIBarButtonItem.appearance().setTitleTextAttributes(attrs3, for: .highlighted)
  }
}
