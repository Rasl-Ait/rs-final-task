
import UIKit
import Kingfisher

extension UIImageView {
  convenience init (_ image: UIImage?, contentMode: ContentMode = .scaleAspectFit) {
    self.init()
    self.contentMode = contentMode
    self.image = image
  }
  
  func download(url: String?, placeholder: UIImage?) {
    self.image = placeholder
    guard let urlString = url else { return }
    let url = URL(string: urlString)
    kf.indicatorType = .activity
    self.kf.setImage(with: url)
  }
}
