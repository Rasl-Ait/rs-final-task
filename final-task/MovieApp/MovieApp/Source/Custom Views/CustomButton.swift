//
//  CustomButton.swift
//  MovieApp
//
//  Created by rasul on 11/6/21.
//

import UIKit.UIButton

final class CustomButton: UIButton {
  init(_ image: UIImage, highlightedImage: UIImage) {
    super.init(frame: .zero)    
    setImage(image, for: .normal)
    setImage(highlightedImage, for: .highlighted)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
