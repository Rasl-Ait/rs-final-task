//
//  Layouts.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

import UIKit

protocol Layouts {
  init(_ value: CFloat)
}

extension Int: Layouts {}
extension UInt: Layouts {}
extension Float: Layouts {}
extension Double: Layouts {}
extension CGFloat: Layouts {}

extension Layouts {
  static var marginXXS: Self { Self(8.0) }
  static var marginXS: Self { Self(10.0) }
  static var marginS: Self { Self(12.0) }
  static var marginSM: Self { Self(14.0) }
  static var marginM: Self { Self(16.0) }
  static var marginML: Self { Self(18.0) }
  static var marginL: Self { Self(20.0) }
  static var marginXL: Self { Self(22.0) }
  static var marginXXL: Self { Self(35.0) }
  static var marginXXXL: Self { Self(40.0) }
}
