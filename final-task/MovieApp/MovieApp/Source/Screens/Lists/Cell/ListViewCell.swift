//
//  ListViewCell.swift
//  MovieApp
//
//  Created by rasul on 11/6/21.
//

import UIKit

final class ListViewCell: UIView {
  
  // MARK: - Properties
  private lazy var nameLabel = makeNameLabel()
  private lazy var countLabel = makeCountLabel()
  private lazy var removeButton = makeRemoveButton()
  private lazy var stackView = makeStackView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func prepareForReuse() {
    nameLabel.text = nil
    countLabel.text = nil
  }
  
  func configure(_ model: ListModel) {
    nameLabel.text = model.name
    countLabel.text = "\(model.itemCount) items"
  }
}

// MARK: - Private Extension
private extension ListViewCell {
  func setupView() {
    backgroundColor = .cellBackground
    layer.cornerRadius = .spacingSM
    addShadow(ofColor: .black, radius: 1, offset: CGSize(width: 0, height: 2), opacity: 0.15)
    apperence()
    setupLayoutUI()
  }
  
  func apperence() {
    addSubview(stackView)
    addSubview(removeButton)
  }
  
  func setupLayoutUI() {
    removeButton.snp.makeConstraints {
      $0.top.equalToSuperview().offset(15)
      $0.leading.equalTo(stackView.snp.trailing).offset(15)
      $0.trailing.equalToSuperview().inset(15)
      $0.height.width.equalTo(30)
    }
    
    stackView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(15)
      $0.leading.equalToSuperview().offset(15)
    }
  }
}

// MARK: - Setup UI
private extension ListViewCell {
  func makeNameLabel() -> UILabel {
    let view = UILabel(
      "List", alignment: .left,
      color: .titleColor ?? .black,
      fontName: .avenir(.fontXL, .Regular)
    )
    return view
  }
  
  func makeCountLabel() -> UILabel {
    let view = UILabel(
      "2 items", alignment: .left,
      color: .cellTitle ?? .black,
      fontName: .avenir(.fontM, .Regular)
    )
    return view
  }
  
  func makeStackView() -> UIStackView {
    let view = CustomStackView(axis: .vertical, spacing: .spacingXXS)
    view.addArrangedSubview(nameLabel)
    view.addArrangedSubview(countLabel)
    return view
  }
  
  func makeRemoveButton() -> UIButton {
    let config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 50))
    let view = CustomButton(.setImage(.delete, configuration: config), highlightedImage: .setImage(.delete, configuration: config))
    view.tintColor = .systemRed
    return view
  }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct ListViewCellRepresentable: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    return ListViewCell()
  }
  func updateUIView(_ view: UIView, context: Context) {
    // do your logic here
  }
}

@available(iOS 13.0, *)
struct ListViewCell_Preview: PreviewProvider {
  static var previews: some View {
    ListViewCellRepresentable()
      .frame(width: UIScreen.main.bounds.width - 20, height: 208)
      .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
      .previewLayout(.fixed(width: UIScreen.main.bounds.width, height: 200))
  }
}
#endif