//
//  AuthPresenter.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//  
//

import Foundation

final class AuthPresenter: AuthViewOutput {
	private let service: AuthServiceProtocol
  weak var coordinator: AuthCoordinatorProtocol?
	weak var view: AuthViewInput?
	
	init(service: AuthServiceProtocol, view: AuthViewInput) {
		self.service = service
		self.view = view
	}
  
  func newToken(_ param: AuthParam) {
    view?.showIndicator()
    service.newToken { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        let param = ValidationWithLoginParam(username: param.username,
                                             password: param.password,
                                             token: item.requestToken)
        self.validationLogin(param)
      case .failure(let error):
        mainQueue {
          self.view?.failure(error: error)
        }
      }
    }
  }
  
  func sessionNew(_ token: String) {
    let param = RequestTokenParam(token: token)
    service.sessionNew(param) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        mainQueue {
          UserDefaults.standard.sessionID = item.sessionId ?? ""
          self.view?.success()
          self.coordinator?.finishFlow?()
        }
      case .failure(let error):
        mainQueue {
          self.view?.failure(error: error)
        }
      }
    }
  }
  
  func validationLogin(_ param: ValidationWithLoginParam) {
    service.validateWithLogin(param) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        self.sessionNew(item.requestToken)
      case .failure(let error):
        mainQueue {
          self.view?.failure(error: error)
        }
      }
    }
  }
}
