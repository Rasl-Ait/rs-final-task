//
//  OverviewView.swift
//  MovieApp
//
//  Created by rasul on 11/10/21.
//

import UIKit

final class OverviewView: UIView {
  
  // MARK: - Properties
  private lazy var label = makeLabel()
  
  // MARK: - Overriden funcs
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(text: String) {
    label.text = text
  }
}

// MARK: - Private Extension
private extension OverviewView {
  func setupView() {
    backgroundColor = .cellBackgroundColor
    setupAppearence()
    setupLayoutUI()
    layer.cornerRadius = 10
    addShadow()
  }
  
  func setupAppearence() {
    addSubview(label)
  }
  
  func setupLayoutUI() {
    label.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(15)
    }
  }
}

// MARK: - Setup UI
private extension OverviewView {
  func makeLabel() -> UILabel {
    let view = UILabel("title",
                       alignment: .left,
                       color: .cellTitleColor,
                       fontName: .avenir(.fontSM, .Regular))
    view.numberOfLines = 0
    return view
  }
}

// MARK: - Constants
extension OverviewView {
  private enum Spacing {
    static let section: CGFloat = .spacingL
  }
}

#if DEBUG
import SwiftUI

struct OverviewViewRepresentable: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    return OverviewView()
  }
  func updateUIView(_ view: UIView, context: Context) {
    // do your logic here
  }
}

@available(iOS 13.0, *)
struct OverviewView_Preview: PreviewProvider {
  static var previews: some View {
    OverviewViewRepresentable()
  }
}
#endif
