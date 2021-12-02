//
//  AppDelegate.swift
//  MovieApp
//
//  Created by rasul on 10/27/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  let coreDataTask = CoreDataStack(modelName: "Model")
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    return true
  }
}
