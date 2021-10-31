//
//  NSSet.swift
//  Wallets
//
//  Created by rasul on 10/3/21.
//

import Foundation

extension NSSet {
  func toArray<T>() -> [T] {
    let array = self.map { $0 as! T }
    return array
  }
}
