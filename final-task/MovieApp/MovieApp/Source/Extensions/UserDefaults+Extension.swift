//
//  UserDefaults.swift
//  Wallets
//
//  Created by rasul on 9/29/21.
//

import Foundation

struct UserDefaultsKeys {
  static let sessionID = "session_id"
}

extension UserDefaults {
  
  var sessionID: String {
    get {
      UserDefaults.standard.string(forKey: UserDefaultsKeys.sessionID) ?? ""
    }
    set(value) {
      UserDefaults.standard.set(value, forKey: UserDefaultsKeys.sessionID)
    }
  }
}
