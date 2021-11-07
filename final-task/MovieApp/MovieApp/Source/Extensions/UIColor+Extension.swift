
import UIKit

extension UIColor {
  convenience init(hex: Int) {
      let components = (
          R: CGFloat((hex >> 16) & 0xff) / 255,
          G: CGFloat((hex >> 08) & 0xff) / 255,
          B: CGFloat((hex >> 00) & 0xff) / 255
      )
      self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
  }

  convenience init(hex: Int, alpha: CGFloat) {
      let components = (
          R: CGFloat((hex >> 16) & 0xff) / 255,
          G: CGFloat((hex >> 08) & 0xff) / 255,
          B: CGFloat((hex >> 00) & 0xff) / 255
      )
      self.init(red: components.R, green: components.G, blue: components.B, alpha: alpha)
  }
  
  static let background = UIColor(named: "Background")!
  static let cellBackground = UIColor(named: "CellBackground")!
  static let cellTitle = UIColor(named: "CellTitle")!
  static let description = UIColor(named: "Description")!
  static let segmentBackground = UIColor(named: "SegmentBackground")!
  static let tabBarDeselect = UIColor(named: "TabBarDeselect")!
  static let titleColor = UIColor(named: "TitleColor")!
}
