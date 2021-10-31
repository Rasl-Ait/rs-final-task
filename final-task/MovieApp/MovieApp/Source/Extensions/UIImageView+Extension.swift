
import UIKit

extension UIImageView {
  convenience init (_ image: UIImage?, contentMode: ContentMode = .scaleAspectFit) {
    self.init()
    disableAutoresizingMask()
    self.contentMode = contentMode
    self.image = image
  }
}
