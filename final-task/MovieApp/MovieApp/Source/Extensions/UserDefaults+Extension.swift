//
//  UserDefaults.swift
//  Wallets
//
//  Created by rasul on 9/29/21.
//

import Foundation

struct UserDefaultsKeys {
  static let sessionID = "session_id"
  static let accountID = "account_id"
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
  
  var accountID: Int {
    get {
      UserDefaults.standard.integer(forKey: UserDefaultsKeys.accountID)
    }
    set(value) {
      UserDefaults.standard.set(value, forKey: UserDefaultsKeys.accountID)
    }
  }
}
