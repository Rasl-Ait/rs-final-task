//
//  Double+Extension.swift
//  MovieApp
//
//  Created by rasul on 11/11/21.
//

import Foundation

extension Double {
  var toInt: Int { return Int(self.rounded()) }
  var toString: String { return String(self) }
}
