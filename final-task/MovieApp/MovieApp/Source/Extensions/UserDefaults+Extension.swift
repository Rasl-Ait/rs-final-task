//
//  UserDefaults.swift
//  Wallets
//
//  Created by rasul on 9/29/21.
//

import Foundation

struct UserDefaultsKeys {
  static let kTheme = "theme"
  static let kDefaulTheme = "defaulTheme"
  static let kScreenType = "screenType"
  static let kWalletIndex = "walletIndex"
}

extension UserDefaults {
  
  var theme: String? {
    get {
      UserDefaults.standard.string(forKey: UserDefaultsKeys.kTheme)
    }
    set(value) {
      UserDefaults.standard.set(value, forKey: UserDefaultsKeys.kTheme)
    }
  }
  
  var defaultTheme: String? {
    get {
      UserDefaults.standard.string(forKey: UserDefaultsKeys.kDefaulTheme)
    }
    set(value) {
      UserDefaults.standard.set(value, forKey: UserDefaultsKeys.kDefaulTheme)
    }
  }
  
  var screenType: String? {
    get {
      UserDefaults.standard.string(forKey: UserDefaultsKeys.kScreenType)
    }
    set(value) {
      UserDefaults.standard.set(value, forKey: UserDefaultsKeys.kScreenType)
    }
  }
  
  var walletIndex: String? {
    get {
      UserDefaults.standard.string(forKey: UserDefaultsKeys.kWalletIndex)
    }
    set(value) {
      UserDefaults.standard.set(value, forKey: UserDefaultsKeys.kWalletIndex)
    }
  }
}
