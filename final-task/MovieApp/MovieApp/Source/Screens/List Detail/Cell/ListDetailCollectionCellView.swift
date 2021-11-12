//
//  ListDetailCollectionCellView.swift
//  MovieApp
//
//  Created by rasul on 11/7/21.
//

import UIKit

enum MovieType {
  case listDetail
  case movieSimilar
  case search
}

final class ListDetailCollectionCellView: UIView {
  // MARK: - Properties
  private lazy var imageView = makeImageView()
  private lazy var titleLabel = makeTitleLabel()
  private lazy var checkButton = makeCheckButton()
  private lazy var stackView = makeStackView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func prepareForReuse() {
    titleLabel.text = nil
    imageView.image = nil
  }
  
  func isEditing(isEditing: Bool) {
    checkButton.isHidden = !isEditing
  }
  
  func isSelected(isSelected: Bool) {
    checkButton.isSelected = isSelected
  }
  
  func configure(_ model: MovieModel, type: MovieType = .listDetail) {
    titleLabel.text = model.originalName != nil ?
      model.originalName :
      model.originalTitle
    checkButton.isHidden = true
    imageView.download(url: model.iconString, placeholder: nil)
    
    if type != .movieSimilar {
      stackView.addArrangedSubview(titleLabel)
    }
  }
}

// MARK: - Private ListDetailCollectionCellView
private extension ListDetailCollectionCellView {
  func setupView() {
    backgroundColor = .cellBackgroundColor
    layer.cornerRadius = .spacingSM
    addShadow()
    setupAppearence()
    setupLayoutUI()
  }
  
  func setupAppearence() {
    addSubview(stackView)
    addSubview(checkButton)
  }
  
  func setupLayoutUI() {
    imageView.snp.makeConstraints {
      $0.height.equalTo(150)
    }
    
    stackView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(7)
      $0.leading.trailing.equalToSuperview().inset(7)
      $0.bottom.equalToSuperview().inset(10)
    }
    
    checkButton.snp.makeConstraints {
      $0.height.width.equalTo(27)
      $0.trailing.equalToSuperview().inset(7)
      $0.bottom.equalToSuperview().inset(7)
    }
  }
}

// MARK: - Setup UI
private extension ListDetailCollectionCellView {
  func makeTitleLabel() -> UILabel {
    let view = UILabel(
      "List", alignment: .center,
      color: .cellTitleColor,
      fontName: .avenir(.fontSM, .SemiBold)
    )
    view.numberOfLines = 0
    return view
  }
  
  func makeImageView() -> UIImageView {
    let view = UIImageView()
    view.contentMode = .scaleAspectFill
    view.layer.cornerRadius = .spacingS
    view.clipsToBounds = true
    return view
  }
  
  func makeStackView() -> UIStackView {
    let view = CustomStackView(axis: .vertical, spacing: .spacingXS)
    view.addArrangedSubview(imageView)
    return view
  }
  
  func makeCheckButton() -> UIButton {
    let view = UIButton()
    view.isUserInteractionEnabled = false
    view.setImage(.setImage(.circle).withColor(.checkButtonColor), for: .normal)
    view.setImage(.setImage(.circleSelect).withColor(.checkButtonColor), for: .selected)
    return view
  }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct ListDetailCollectionCellViewRepresentable: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    return ListDetailCollectionCellView()
  }
  func updateUIView(_ view: UIView, context: Context) {
    // do your logic here
  }
}

@available(iOS 13.0, *)
struct ListDetailCollectionCellView_Preview: PreviewProvider {
  static var previews: some View {
    ListDetailCollectionCellViewRepresentable()
      .frame(width: 160, height: 208)
      .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
      .previewLayout(.fixed(width: UIScreen.main.bounds.width, height: 400))
  }
}
#endif
