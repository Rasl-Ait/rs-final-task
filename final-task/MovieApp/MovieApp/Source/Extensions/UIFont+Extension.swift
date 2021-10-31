
import UIKit

extension UIFont {
  enum Prettiness: String {
    case Regular
    case Medium
    case Bold
    case SemiBold
  }
  
  static func montserrat(_ size: FontSize, _ type: Prettiness) -> UIFont {
    UIFont(name: "Montserrat-\(type.rawValue.capitalized)",
           size: size.rawValue) ?? .systemFont(ofSize: size.rawValue)
  }
}
