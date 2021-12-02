
import UIKit

extension UIFont {
  enum Prettiness: String {
    case Regular
    case Medium
    case Bold
    case SemiBold
  }
  
  static func avenir(_ size: CGFloat, _ type: Prettiness) -> UIFont {
    UIFont(name: "Avenir-Next-\(type.rawValue.capitalized)",
           size: size) ?? .systemFont(ofSize: size)
  }
}
