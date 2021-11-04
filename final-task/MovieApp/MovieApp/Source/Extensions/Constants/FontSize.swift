//
//  FontSize.swift
//  MovieApp
//
//  Created by rasul on 11/4/21.
//

import UIKit

protocol FontSize {
  init(_ value: CGFloat)
}

extension CGFloat: FontSize {}

extension FontSize {
  static var fontXXS: Self { Self(8.0) }
  static var fontXS: Self { Self(10.0) }
  static var fontS: Self { Self(12.0) }
  static var fontSM: Self { Self(14.0) }
  static var fontM: Self { Self(16.0) }
  static var fontML: Self { Self(18.0) }
  static var fontL: Self { Self(20.0) }
  static var fontXL: Self { Self(22.0) }
  static var fontXXL: Self { Self(24.0) }
}
