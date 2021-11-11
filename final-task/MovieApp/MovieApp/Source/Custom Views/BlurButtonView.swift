//
//  BlurButtonView.swift
//  MovieApp
//
//  Created by rasul on 11/10/21.
//

import UIKit

class BlurButtonView: UIView {
  // MARK: - Properties
  private lazy var button = makeButton()
  
  // MARK: - Closure
  var didButtonClicked: VoidClosure?
  
  init(image: UIImage) {
    super.init(frame: .zero)
    button.setImage(image, for: .normal)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: private BlurButtonView
private extension BlurButtonView {
  func setupViews() {
    
    layer.cornerRadius = 40 / 2
    clipsToBounds = true
    //
    addBlurToView()
    addSubview(button)
    setupLayoutUI()
  }
  
  func setupLayoutUI() {
    button.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.height.width.equalTo(40)
    }
  }
  
  func makeButton() -> UIButton {
    let view = UIButton(type: .system)
    view.setImage(.setImage(.close), for: .normal)
    view.tintColor = .white
    view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    return view
  }
  
  // MARK: Action func
  @objc func buttonTapped() {
    didButtonClicked?()
  }
}
