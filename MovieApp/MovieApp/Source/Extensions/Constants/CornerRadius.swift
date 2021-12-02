//
//  CornerRadius.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

import UIKit

protocol CornerRadius {
  init(_ value: CGFloat)
}

extension Int: CornerRadius {}
extension UInt: CornerRadius {}
extension Float: CornerRadius {}
extension Double: CornerRadius {}
extension CGFloat: CornerRadius {}

extension CornerRadius {
  static var radiusXXS: Self { Self(8.0) }
  static var radiusXS: Self { Self(10.0) }
  static var radiusS: Self { Self(12.0) }
  static var radiusSM: Self { Self(14.0) }
  static var radiusM: Self { Self(16.0) }
  static var radiusML: Self { Self(18.0) }
  static var radiusL: Self { Self(20.0) }
  static var radiusXL: Self { Self(22.0) }
  static var radiusXXL: Self { Self(24.0) }
  static var radiusXXXL: Self { Self(30.0) }
}
