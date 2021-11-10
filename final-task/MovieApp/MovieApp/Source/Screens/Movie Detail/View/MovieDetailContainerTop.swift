//
//  MovieDetailContainerTop.swift
//  MovieApp
//
//  Created by rasul on 11/10/21.
//

import UIKit
import SnapKit

final class MovieDetailContainerTop: UIView {
  
  // MARK: - Properties
  private lazy var movieImage = makeMovieImageView()
  private lazy var closeView = makeButtonView(image: .setImage(.close))
  private lazy var infoView = makeButtonView(image: .setImage(.info))
  private lazy var listView = makeButtonView(image: .setImage(.list))
  private lazy var favoriteView = makeButtonView(image: .setImage(.heart))
  private lazy var rateView = makeButtonView(image: .setImage(.star))
  private lazy var stackView = makeStackView()
  private lazy var progressView = makeProgressView()
  
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
  
  func addMovie(_ items: [MovieModel]) {
    
  }
}

// MARK: - Private Extension
private extension MovieDetailContainerTop {
  func setupView() {
    backgroundColor = .backgroundColor
    setupAppearence()
    setupLayoutUI()
  }
  
  func setupAppearence() {
    addSubview(movieImage)
    addSubview(closeView)
    addSubview(infoView)
    addSubview(progressView)
    addSubview(stackView)
  }
  
  func setupLayoutUI() {
    closeView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(30)
      $0.height.width.equalTo(40)
      $0.trailing.equalToSuperview().inset(15)
    }
    
    infoView.snp.makeConstraints {
      $0.top.equalTo(closeView.snp.bottom).offset(20)
      $0.height.width.equalTo(closeView)
      $0.trailing.equalTo(closeView)
    }
    
    movieImage.snp.makeConstraints {
      $0.height.width.equalTo(UIScreen.height / 1.6)
      $0.leading.trailing.equalToSuperview()
      $0.top.equalToSuperview()
    }
    
    favoriteView.snp.makeConstraints {
      $0.height.width.equalTo(40)
    }
    
    progressView.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(15)
      $0.height.width.equalTo(60)
      $0.centerY.equalTo(stackView)
    }
    
    stackView.snp.makeConstraints {
      $0.trailing.equalToSuperview().inset(15)
      $0.bottom.equalTo(movieImage.snp.bottom).inset(30)
    }
  }
  
  // MARK: Action func
  @objc func removeButtonTapped() {

  }
}

// MARK: - Setup UI
private extension MovieDetailContainerTop {
  func makeMovieImageView() -> ImageViewGradient {
    let view = ImageViewGradient()
    view.image = UIImage(named: "bg-image")
    return view
  }
  
  func makeButtonView(image: UIImage) -> BlurButtonView {
    let view = BlurButtonView(image: image)
    return view
  }
  
  func makeStackView() -> UIStackView {
    let view = CustomStackView(axis: .horizontal, spacing: 10)
    view.distribution = .fillEqually
    view.addArrangedSubview(listView)
    view.addArrangedSubview(favoriteView)
    view.addArrangedSubview(rateView)
    return view
  }
  
  func makeProgressView() -> ProgressView {
    let view = ProgressView()
    return view
  }
}

// MARK: - Constants
extension MovieDetailContainerTop {
  private enum Spacing {
    static let section: CGFloat = .spacingL
  }
}

#if DEBUG
import SwiftUI

struct MovieDetailContainerTopRepresentable: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    return MovieDetailContainerTop()
  }
  func updateUIView(_ view: UIView, context: Context) {
    // do your logic here
  }
}

@available(iOS 13.0, *)
struct MovieDetailContainerTop_Preview: PreviewProvider {
  static var previews: some View {
    MovieDetailContainerTopRepresentable()
  }
}
#endif
