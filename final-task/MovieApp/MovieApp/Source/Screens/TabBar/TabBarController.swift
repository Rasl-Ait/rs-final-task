//
//  TabBarController.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//

import UIKit

final class TabBarController: UITabBarController {
  
  enum TabBarItem: Int {
    case home
    case movies
    case search
    case favorite
    case profile
  }
  
  private let tabBarItems = [
    UITabBarItem(title: ScreenType.home.rawValue.capitalized, image: .setImage(.home), tag: 0),
    UITabBarItem(title: ScreenType.movies.rawValue.capitalized, image: .setImage(.movies), tag: 1),
    UITabBarItem(title: ScreenType.search.rawValue.capitalized, image: .setImage(.search), tag: 2),
    UITabBarItem(title: ScreenType.favorite.rawValue.capitalized, image: .setImage(.heart), tag: 3),
    UITabBarItem(title: ScreenType.profile.rawValue.capitalized, image: .setImage(.profile), tag: 4)
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tabBar.tintColor = .tabBarTintColor
    tabBar.barTintColor = .tabBarBarTintColor
    tabBar.isTranslucent = true
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    configureNavigationBar(isHidden: true, barStyle: .default)
  }
  
  func configureNavigationBar(isHidden: Bool, barStyle: UIBarStyle) {
    navigationController?.navigationBar.isHidden = isHidden
    navigationController?.navigationBar.barStyle = barStyle
  }
  
  func appendNavigationController(_ vc: UINavigationController, item: TabBarItem) {
    customizeNavigationController(vc, item: item)
    viewControllers = (viewControllers ?? []) + [vc]
  }
}

private extension TabBarController {
  private func customizeNavigationController(
    _ navigationController: UINavigationController,
    item: TabBarItem) {
    navigationController.tabBarItem = tabBarItems[item.rawValue]
  }
}
