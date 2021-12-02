
import UIKit

extension UIEdgeInsets {
  init(all i: CGFloat) {
      self.init(top: i, left: i, bottom: i, right: i)
  }
  
  init(left i: CGFloat) {
      self.init(top: 0, left: i, bottom: 0, right: 0)
  }

  init(right i: CGFloat) {
      self.init(top: 0, left: 0, bottom: 0, right: i)
  }

  init(top i: CGFloat) {
      self.init(top: i, left: 0, bottom: 0, right: 0)
  }

  init(bottom i: CGFloat) {
      self.init(top: 0, left: 0, bottom: i, right: 0)
  }

  init(leftRight i: CGFloat) {
      self.init(top: 0, left: i, bottom: 0, right: i)
  }

  init(topBottom i: CGFloat) {
      self.init(top: i, left: 0, bottom: i, right: 0)
  }

  static func all(_ i: CGFloat) -> UIEdgeInsets {
      .init(all: i)
  }

  static func left(_ i: CGFloat) -> UIEdgeInsets {
      .init(left: i)
  }

  static func right(_ i: CGFloat) -> UIEdgeInsets {
      .init(right: i)
  }

  static func top(_ i: CGFloat) -> UIEdgeInsets {
      .init(top: i)
  }

  static func bottom(_ i: CGFloat) -> UIEdgeInsets {
      .init(bottom: i)
  }

  static func leftRight(_ i: CGFloat) -> UIEdgeInsets {
      .init(leftRight: i)
  }

  static func topBottom(_ i: CGFloat) -> UIEdgeInsets {
      .init(topBottom: i)
  }
}
