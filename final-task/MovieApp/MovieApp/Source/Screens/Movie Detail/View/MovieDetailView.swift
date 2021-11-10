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
  private lazy var collectionView = makeCollectionView()
  
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
}

// MARK: - Private Extension
private extension MovieDetailView {
  func setupView() {
    backgroundColor = .backgroundColor
    setupAppearence()
    setupLayoutUI()
  }
  
  func setupAppearence() {
    addSubview(containerTopView)
    addSubview(collectionView)
  }
  
  func setupLayoutUI() {
    containerTopView.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.height.equalTo(UIScreen.height / 1.6)
      $0.leading.trailing.equalToSuperview()
    }
    
    collectionView.snp.makeConstraints {
      $0.top.equalTo(containerTopView.snp.bottom).offset(20)
      $0.height.equalTo(180)
      $0.leading.trailing.equalToSuperview()
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
