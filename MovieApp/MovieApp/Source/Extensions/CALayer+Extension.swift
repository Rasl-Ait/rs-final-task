//
//  CALayer.swift
//  SpaseX
//
//  Created by rasul on 9/22/21.
//

import UIKit

extension CALayer {
  func applySketchShadow(
    color: UIColor = .black,
    alpha: Float = 0.5,
    x: CGFloat = 0,
    y: CGFloat = 2,
    blur: CGFloat = 4,
    radius: CGFloat = 0) {
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = blur
    shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
    masksToBounds = false
  }
}
