//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by rasul on 11/10/21.
//

import UIKit
import SnapKit

final class MovieDetailView: UIView {
  
  // MARK: - Properties
  private lazy var containerTopView = makeContainerView()
  private lazy var videoCollectionView = makeCollectionView()
  private lazy var titleLabel = makeLabel(textColor: .cellTitleColor, font: .avenir(.fontL, .Regular))
  private lazy var dateLabel = makeLabel(textColor: .cellTitleColor, font: .avenir(.fontM, .Regular))
  private lazy var overviewLabel = makeLabel(textColor: .cellHeaderTitleColor, font: .avenir(.fontXXXL + 6, .Regular))
  private lazy var movieBodyView = makeMovieBodyView()
  private lazy var overview = makeOverview()
  private lazy var similarView = makeSimilarView()
  
  // MARK: - Closure
  var didSimilarSelectRowAt: ItemClosure<Int>?
  var didButtonClicked: ItemClosure<BlurButtonType>?
  
  // MARK: - Overriden funcs
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(type: DetailContentType) {
    switch type {
    case .movie(let model):
      movieBodyView.configure(model: model)
      titleLabel.text = model.originalTitle
      dateLabel.text = model.releaseDate.formatDate()
      overviewLabel.text = "Overview"
      overview.configure(text: model.overview)
      containerTopView.configure(model: model)
    case .video(let videos):
      videoCollectionView.addMovie(videos)
    case .similarVideo(let movies):
    similarView.addMovie(movies)
    }
  }
  
}

// MARK: - Private Extension
private extension MovieDetailView {
  func setupView() {
    backgroundColor = .backgroundColor
    setupAppearence()
    setupLayoutUI()
    closures()
  }
  
  func setupAppearence() {
    addSubview(containerTopView)
    addSubview(videoCollectionView)
    addSubview(titleLabel)
    addSubview(dateLabel)
    addSubview(movieBodyView)
    addSubview(overviewLabel)
    addSubview(overview)
    addSubview(similarView)
  }
  
  func setupLayoutUI() {
    containerTopView.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.height.equalTo(UIScreen.height / 1.6)
      $0.leading.trailing.equalToSuperview()
    }
    
    videoCollectionView.snp.makeConstraints {
      $0.top.equalTo(containerTopView.snp.bottom).offset(10)
      $0.height.equalTo(180)
      $0.leading.trailing.equalToSuperview()
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(videoCollectionView.snp.bottom).offset(25)
      $0.height.equalTo(20)
      $0.centerX.equalToSuperview()
    }
    
    dateLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(8)
      $0.height.equalTo(20)
      $0.centerX.equalToSuperview()
    }
    
    movieBodyView.snp.makeConstraints {
      $0.top.equalTo(dateLabel.snp.bottom).offset(25)
      $0.leading.trailing.equalToSuperview().inset(15)
    }
    
    overviewLabel.snp.makeConstraints {
      $0.top.equalTo(movieBodyView.snp.bottom).offset(25)
      $0.height.equalTo(40)
      $0.centerX.equalToSuperview()
    }
    
    overview.snp.makeConstraints {
      $0.top.equalTo(overviewLabel.snp.bottom).offset(25)
      $0.leading.trailing.equalToSuperview().inset(15)
    }
    similarView.snp.makeConstraints {
      $0.top.equalTo(overview.snp.bottom).offset(80)
      $0.leading.trailing.equalToSuperview().inset(15)
      $0.height.equalTo(250)
      $0.bottom.equalToSuperview().inset(20)
    }
  }
  
  // MARK: Action func
  @objc func removeButtonTapped() {
    
  }
}

// MARK: - Setup UI
private extension MovieDetailView {
  func makeContainerView() -> MovieDetailContainerTop {
    let view = MovieDetailContainerTop()
    return view
  }
  
  func makeCollectionView() -> VideoView {
    let view = VideoView()
    return view
  }
  
  func makeLabel(textColor: UIColor, font: UIFont) -> UILabel {
    let view = UILabel("title",
                       alignment: .center,
                       color: textColor,
                       fontName: font)
    return view
  }
  
  func makeMovieBodyView() -> MovieBodyView {
    let view = MovieBodyView()
    return view
  }
  
  func makeSimilarView() -> SimilarMovieView {
    let view = SimilarMovieView()
    return view
  }
  
  func makeOverview() -> OverviewView {
    let view = OverviewView()
    return view
  }
}

// MARK: Closure
private extension MovieDetailView {
  func closures() {
    containerTopView.didButtonClicked = { [weak self] buttonType in
      guard let self = self else { return }
      self.didButtonClicked?(buttonType)
    }
    
    similarView.didSelectRowAt = { [weak self] id in
      guard let self = self else { return }
      self.didSimilarSelectRowAt?(id)
    }
  }
}

// MARK: - Constants
extension MovieDetailView {
  private enum Spacing {
    static let section: CGFloat = .spacingL
  }
}

#if DEBUG
import SwiftUI

struct MovieDetailViewRepresentable: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    return MovieDetailView()
  }
  func updateUIView(_ view: UIView, context: Context) {
    // do your logic here
  }
}

@available(iOS 13.0, *)
struct MovieDetailView_Preview: PreviewProvider {
  static var previews: some View {
    MovieDetailViewRepresentable()
  }
}
#endif
