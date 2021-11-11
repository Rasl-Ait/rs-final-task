//
//  ProgressView.swift
//  MovieApp
//
//  Created by rasul on 11/10/21.
//

import UIKit

final class ProgressView: UIView {
  
  // MARK: - Properties
  private lazy var label = makeLabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(movie: MovieDetailModel) {
    label.text = "\(movie.score)%"
  }
}

private extension ProgressView {
  func setupView() {
    backgroundColor = .gray
    layer.cornerRadius = height / 2
    addSubview(label)
    
    setupLayoutUI()
  }
  
  func setupLayoutUI() {
    label.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  func makeLabel() -> UILabel {
    let view = UILabel("75%", alignment: .center, color: .white, fontName: .avenir(.fontM, .Bold))
    return view
  }
}

#if DEBUG
import SwiftUI

struct ProgressViewRepresentable: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    return ProgressView()
  }
  func updateUIView(_ view: UIView, context: Context) {
    // do your logic here
  }
}

@available(iOS 13.0, *)
struct ProgressView_Preview: PreviewProvider {
  static var previews: some View {
    ProgressViewRepresentable()
      .frame(width: 60, height: 60)
      .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
      .previewLayout(.fixed(width: 60, height: 60))
  }
}
#endif
