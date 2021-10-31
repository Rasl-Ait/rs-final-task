
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
  
  static let rickBlack = UIColor(hex: 0x071013)
  static let celadon = UIColor(hex: 0x36AA00)
  static let honeydew = UIColor(hex: 0xE2EFDE)
  static let customPink = UIColor(hex: 0xF8C0C8)
  static let lightCyan = UIColor(hex: 0xCDF7F6)
  static let babyPowder = UIColor(hex: 0xFFFFFB)
  static let darkPurple = UIColor(hex: 0x140F2D)
  static let deepSaffron = UIColor(hex: 0xF49D37)
  static let greenBlueCrayola = UIColor(hex: 0x3F88C5)
  static let amaranthRed = UIColor(hex: 0xD72638)
}
