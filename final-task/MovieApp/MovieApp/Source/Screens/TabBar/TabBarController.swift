//
//  TabBarController.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//

import UIKit

final class TabBarController: UITabBarController, TabBarViewProtocol {
  var onViewDidLoad: ItemClosure<NavigationController>?
  var onListsFlowSelect: ItemClosure<NavigationController>?
  var onSearchFlowSelect: ItemClosure<NavigationController>?
  var onFavoriteFlowSelect: ItemClosure<NavigationController>?
  
  private let tabBarItems = [
    UITabBarItem(title: ScreenType.home.rawValue.capitalized, image: .setImage(.home), tag: 0),
    UITabBarItem(title: ScreenType.search.rawValue.capitalized, image: .setImage(.search), tag: 1),
    UITabBarItem(title: ScreenType.favorite.rawValue.capitalized, image: .setImage(.heart), tag: 2)
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTabBar()
  }
  
  deinit {
    Log.logInfo(text: "Delete tabBar vc")
  }
  
  private func setupTabBar() {
    tabBar.tintColor = .tabBarTintColor
    tabBar.barTintColor = .tabBarBarTintColor
    tabBar.isTranslucent = true
    delegate = self
    viewControllers = [generateViewController(item: .home),
                       generateViewController(item: .search),
                       generateViewController(item: .favorite)]
    setOnViewDidLoadCompletion()
  }
  
  private func setOnViewDidLoadCompletion() {
    guard let controller = viewControllers?.first as? NavigationController else { return }
    DispatchQueue.main.async {
      self.onViewDidLoad?(controller)
    }
  }
}

private extension TabBarController {
  private func generateViewController(item: TabBarItem) -> NavigationController {
    let navigationController = NavigationController()
    navigationController.tabBarItem = tabBarItems[item.rawValue]
    return navigationController
  }
}

// MARK: UITabBarControllerDelegate
extension TabBarController: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    guard let controller = viewControllers?[selectedIndex] as? NavigationController else { return }
    
     switch selectedIndex {
     case 0:
       onListsFlowSelect?(controller)
     case 1:
       onSearchFlowSelect?(controller)
     case 2:
       onFavoriteFlowSelect?(controller)
     default:
       break
     }
  }
}
