//
//  ScreenFactory.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

import Foundation

final class ScreenFactory: ScreenFactoryProtocol {
  func makeAuthScreen() -> AuthViewController {
    let vc = AuthViewController()
    let service = AuthService(client: NetworkService())
    let presenter = AuthPresenter(service: service, view: vc)
    vc.presenter = presenter
    return vc
  }
}
