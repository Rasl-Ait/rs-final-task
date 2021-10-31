//
//  Currency.swift
//  Wallets
//
//  Created by rasul on 9/29/21.
//

import Foundation

enum Currency {
  static func symbol(for code: String) -> String {
    NSLocale(localeIdentifier: Locale.current.identifier)
      .displayName(forKey: .currencySymbol, value: code) ?? code
  }
  
  static func name(for code: String) -> String {
    Locale.current.localizedString(forCurrencyCode: code) ?? code
  }
}
