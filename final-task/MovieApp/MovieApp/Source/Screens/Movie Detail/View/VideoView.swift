//
//  VideoView.swift
//  MovieApp
//
//  Created by rasul on 11/10/21.
//

import UIKit

final class VideoView: UIView {
  
  // MARK: - Properties
  lazy var collectionView = makeCollectionView()
  private lazy var dataSource = configureDataSource()
  
  enum Section {
    case all
  }
  
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
  
  func addMovie(_ items: [MovieVideo]) {
    updateSnapshot(items)
  }
}

// MARK: - Private Extension
private extension VideoView {
  func setupView() {
    backgroundColor = .backgroundColor
    setupAppearence()
    setupLayoutUI()
    collectionView.dataSource = dataSource
  }
  
  func setupAppearence() {
    addSubview(collectionView)
  }
  
  func setupLayoutUI() {
    collectionView.snp.makeConstraints {
      $0.top.equalTo(safeAreaLayoutGuide.snp.top)
      $0.right.left.bottom.equalToSuperview()
    }
  }
  
  // MARK: Action func
  @objc func removeButtonTapped() {
  }
}

// MARK: - Setup UI
private extension VideoView {
  func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
    let sectionProvider = { (_: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(230))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      // item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
      
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
      let spacing = CGFloat(Spacing.section)
      group.interItemSpacing = .fixed(spacing)
      
      let section = NSCollectionLayoutSection(group: group)
      section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
      section.interGroupSpacing = Spacing.section
      
      return section
    }
    
    return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
  }
  
  func makeCollectionView() -> UICollectionView {
    let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    view.disableAutoresizingMask()
    view.backgroundColor = .red
    view.showsVerticalScrollIndicator = false
    view.register(VideoCollectionCell.self)
    return view
  }
}

// MARK: - Data Source
private extension VideoView {
  func configureDataSource() -> UICollectionViewDiffableDataSource<Section, MovieVideo> {
    let dataSource = UICollectionViewDiffableDataSource<Section, MovieVideo>(
      collectionView: collectionView) { collectionView, indexPath, model in
      let cell: VideoCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
      cell.configure(model: model)
      return cell
    }
    
    return dataSource
  }
  
  func updateSnapshot(_ items: [MovieVideo], animatingChange: Bool = false) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, MovieVideo>()
    snapshot.appendSections([.all])
    snapshot.appendItems(items, toSection: .all)
    dataSource.apply(snapshot, animatingDifferences: false)
  }
}

// MARK: UICollectionViewDelegate
extension VideoView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: false)
    print(#function)
  }
}

// MARK: - Constants
extension VideoView {
  private enum Spacing {
    static let section: CGFloat = .spacingL
  }
}

#if DEBUG
import SwiftUI

struct VideoViewRepresentable: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    return VideoView()
  }
  func updateUIView(_ view: UIView, context: Context) {
    // do your logic here
  }
}

@available(iOS 13.0, *)
struct VideoView_Preview: PreviewProvider {
  static var previews: some View {
    VideoViewRepresentable()
  }
}
#endif
