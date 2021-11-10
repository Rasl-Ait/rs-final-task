//
//  ImageViewGradient.swift
//  MovieApp
//
//  Created by rasul on 11/10/21.
//

import UIKit

class ImageViewGradient: UIImageView {
  
  private let gradient = CAGradientLayer()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupGradient()
  }
  
  init() {
    super.init(frame: .zero)
    setupGradient()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupGradient() {
    gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
    layer.cornerRadius = 18
    
    gradient.locations = [0.5, 1.1]
    clipsToBounds = true
    layer.addSublayer(gradient)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    gradient.frame = layer.bounds
  }
}
