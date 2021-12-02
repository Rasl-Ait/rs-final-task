//
//  MovieBodyView.swift
//  MovieApp
//
//  Created by rasul on 11/10/21.
//

import UIKit

final class MovieBodyView: UIView {
  
  // MARK: - Properties
  private lazy var genresLabel = makeLabel()
  private lazy var languageLabel = makeLabel()
  private lazy var runtimeLabel = makeLabel()
  private lazy var budgetLabel = makeLabel()
  private lazy var revenueLabel = makeLabel()
  private lazy var statusLabel = makeLabel()
  private lazy var stackView = makeStackView()

  // MARK: - Closure
  var didRemoveButton: ItemClosure<MovieModel>?
  
  // MARK: - Overriden funcs
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(model: MovieDetailModel) {
    genresLabel.text = "Genres: \(model.genresString)"
    languageLabel.text = "OriginalLanguage: \(model.languagesString)"
    runtimeLabel.text = "Runtime: \(model.shortFormatDuration)"
    budgetLabel.text = "Budget: $\(model.budget)"
    revenueLabel.text = "Revenue: $\(model.revenue)"
    statusLabel.text = "Status: \(model.status)"
  }
}

// MARK: - Private Extension
private extension MovieBodyView {
  func setupView() {
    backgroundColor = .cellBackgroundColor
    setupAppearence()
    setupLayoutUI()
    layer.cornerRadius = 10
    addShadow()
  }
  
  func setupAppearence() {
    addSubview(stackView)
  }
  
  func setupLayoutUI() {
    stackView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(20)
      $0.leading.equalToSuperview().inset(15)
      $0.bottom.equalToSuperview().inset(20)
    }
  }
}

// MARK: - Setup UI
private extension MovieBodyView {
  func makeLabel() -> UILabel {
    let view = UILabel("title",
                       alignment: .left,
                       color: .cellTitleColor,
                       fontName: .avenir(.fontSM, .Regular))
    return view
  }
  
  func makeStackView() -> UIStackView {
    let view = CustomStackView(axis: .vertical, spacing: 15)
    view.distribution = .fillEqually
    view.addArrangedSubview(genresLabel)
    view.addArrangedSubview(runtimeLabel)
    view.addArrangedSubview(budgetLabel)
    view.addArrangedSubview(revenueLabel)
    view.addArrangedSubview(statusLabel)
    return view
  }
}

// MARK: - Constants
extension MovieBodyView {
  private enum Spacing {
    static let section: CGFloat = .spacingL
  }
}

#if DEBUG
import SwiftUI

struct MovieBodyViewRepresentable: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    return MovieBodyView()
  }
  func updateUIView(_ view: UIView, context: Context) {
    // do your logic here
  }
}

@available(iOS 13.0, *)
struct MovieBodyView_Preview: PreviewProvider {
  static var previews: some View {
    MovieBodyViewRepresentable()
      .frame(width: UIScreen.width, height: 500)
      .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
      .previewLayout(.fixed(width: UIScreen.width, height: 500))
  }
}
#endif
