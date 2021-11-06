//
//  SceneDelegate.swift
//  MovieApp
//
//  Created by rasul on 10/27/21.
//

import UIKit
import CocoaLumberjackSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  private lazy var appFactory: AppFactory = Di()
  private let coreDataTask = CoreDataStack(modelName: "Model")
  var window: UIWindow?
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(windowScene: windowScene)
    let coordinator = appFactory.makeKeyWindowWithCoordinator(window: window!)
    coordinator.start()

    setupLogger()
  }
  
  func sceneDidDisconnect(_ scene: UIScene) {

  }
  
  func sceneDidBecomeActive(_ scene: UIScene) {

  }
  
  func sceneWillResignActive(_ scene: UIScene) {

  }
  
  func sceneWillEnterForeground(_ scene: UIScene) {

  }
  
  func sceneDidEnterBackground(_ scene: UIScene) {
    coreDataTask.saveContext()
  }
  
  private func setupLogger() {
    DDLog.add(DDOSLogger.sharedInstance) // Uses os_log
    let fileLogger: DDFileLogger = DDFileLogger()
    fileLogger.rollingFrequency = TimeInterval(60 * 60 * 24)
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7
    DDLog.add(fileLogger)
  }
}
