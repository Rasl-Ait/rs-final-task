//
//  AnimationButton.swift
//  MovieApp
//
//  Created by rasul on 11/11/21.
//

import UIKit

final class AnimationButton: UIButton {

  override var isHighlighted: Bool {
    didSet {
      if isHighlighted {
        tintColor = tintColor?.withAlphaComponent(0.5)
      } else {
        tintColor = tintColor?.withAlphaComponent(1.0)
      }
    }
  }
  
  var isOn: Bool = false {
    didSet {
      UIView.animate(withDuration: 0.1) {
        self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
      } completion: { _ in
        UIView.animate(withDuration: 0.3) {
          self.transform = .identity
        }
      }
    }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      super.touchesEnded(touches, with: event)
      isOn.toggle()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initialSetup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(title: String, font: UIFont, backgroundColor: UIColor) {
    super.init(frame: .zero)
    self.backgroundColor = backgroundColor
    self.setTitle(title, for: .normal)
    initialSetup()
  }
  
  init(image: UIImage) {
    super.init(frame: .zero)
    self.backgroundColor = backgroundColor
    self.setImage(image, for: .normal)
    initialSetup()
  }
  
  private func initialSetup() {
    setTitleColor(.white, for: .normal)
    translatesAutoresizingMaskIntoConstraints = false
  }
}
