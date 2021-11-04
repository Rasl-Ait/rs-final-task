//
//  Spacing.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

import UIKit

protocol Spacing {
  init(_ value: Double)
}

extension CGFloat: Spacing {}

extension Spacing {
  static var spacingXXS: Self { Self(8.0) }
  static var spacingXS: Self { Self(10.0) }
  static var spacingS: Self { Self(12.0) }
  static var spacingSM: Self { Self(14.0) }
  static var spacingM: Self { Self(16.0) }
  static var spacingML: Self { Self(18.0) }
  static var spacingL: Self { Self(20.0) }
  static var spacingXL: Self { Self(22.0) }
  static var spacingXXL: Self { Self(24.0) }
}
