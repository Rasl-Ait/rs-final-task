//
//  EmptyView.swift
//  MovieApp
//
//  Created by rasul on 11/19/21.
//

import UIKit

final class EmptyView: UIView {
  
  // MARK: - Properties
  private lazy var emptyLabel = makeLabel()
  
  // MARK: - Overriden funcs
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setText(text: TextType) {
    emptyLabel.text = text.rawValue
  }
}

// MARK: - Private Extension
private extension EmptyView {
  func setupView() {
    backgroundColor = .backgroundColor
    setupAppearence()
    setupLayoutUI()
  }
  
  func makeLabel() -> UILabel {
    let view = UILabel("Empty", alignment: .center, color: .cellTitleColor, fontName: .avenir(.marginL, .Regular))
    view.numberOfLines = 0
    return view
  }
  
  func setupAppearence() {
    addSubview(emptyLabel)
  }
  
  func setupLayoutUI() {
    emptyLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(80)
      $0.leading.trailing.equalToSuperview().inset(15)
    }
  }
}

#if DEBUG
import SwiftUI

struct EmptyViewRepresentable: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    return EmptyView()
  }
  func updateUIView(_ view: UIView, context: Context) {
    // do your logic here
  }
}

@available(iOS 13.0, *)
struct EmptyView_Preview: PreviewProvider {
  static var previews: some View {
    EmptyViewRepresentable()
  }
}
#endif
