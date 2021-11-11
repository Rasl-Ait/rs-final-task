//
//  SimilarMovieView.swift
//  MovieApp
//
//  Created by rasul on 11/10/21.
//

import UIKit

final class SimilarMovieView: UIView {
  
  // MARK: - Properties
  private lazy var collectionView = makeCollectionView()
  private lazy var dataSource = configureDataSource()
  private lazy var label = makeLabel()
  
  private var deleteIndexPath: IndexPath!
  private var movies: [MovieModel] = []
  
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
  
  func addMovie(_ items: [MovieModel]) {
    self.movies = items
    updateSnapshot(items)
  }
}

// MARK: - Private Extension
private extension SimilarMovieView {
  func setupView() {
    backgroundColor = .clear
    setupAppearence()
    setupLayoutUI()

    collectionView.dataSource = dataSource
  }
  
  func setupAppearence() {
    addSubview(label)
    addSubview(collectionView)
  }
  
  func setupLayoutUI() {
    label.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.right.left.equalToSuperview()
    }
    
    collectionView.snp.makeConstraints {
      $0.top.equalTo(label.snp.bottom).offset(10)
      $0.right.left.equalToSuperview()
      $0.bottom.equalToSuperview()
    }
  }
  
  // MARK: Action func
  @objc func removeButtonTapped() {
  }
}

// MARK: - Setup UI
private extension SimilarMovieView {
  func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
    let sectionProvider = { (_: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(164))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      // item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
      
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.35), heightDimension: .estimated(1.0))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
      let spacing = CGFloat(10)
      group.interItemSpacing = .fixed(spacing)
      
      let section = NSCollectionLayoutSection(group: group)
      section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
      section.interGroupSpacing = 10
      section.orthogonalScrollingBehavior = .groupPaging
      return section
    }
    
    return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
  }
  
  func makeCollectionView() -> UICollectionView {
    let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    view.backgroundColor = .clear
    view.showsVerticalScrollIndicator = false
    view.register(ListDetailCollectionCell.self)
    return view
  }
  
  func makeLabel() -> UILabel {
    let view = UILabel("Similar Movie",
                       alignment: .left,
                       color: .cellHeaderTitleColor,
                       fontName: .avenir(.fontL, .Regular))
    return view
  }
}

// MARK: - Data Source
private extension SimilarMovieView {
  func configureDataSource() -> UICollectionViewDiffableDataSource<Section, MovieModel> {
    let dataSource = UICollectionViewDiffableDataSource<Section, MovieModel>(
      collectionView: collectionView) { collectionView, indexPath, model in
      let cell: ListDetailCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
      cell.configure(model: model, type: .movieSimilar)
      return cell
    }
    
    return dataSource
  }
  
  func updateSnapshot(_ items: [MovieModel], animatingChange: Bool = false) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, MovieModel>()
    snapshot.appendSections([.all])
    snapshot.appendItems(items, toSection: .all)
    
    dataSource.apply(snapshot, animatingDifferences: false)
  }
}

// MARK: UICollectionViewDelegate
extension SimilarMovieView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: false)
    print(#function)
    
  }
}

// MARK: - Constants
extension SimilarMovieView {
  private enum Spacing {
    static let section: CGFloat = .spacingL
  }
}

#if DEBUG
import SwiftUI

struct SimilarMovieViewRepresentable: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    return SimilarMovieView()
  }
  func updateUIView(_ view: UIView, context: Context) {
    // do your logic here
  }
}

@available(iOS 13.0, *)
struct SimilarMovieView_Preview: PreviewProvider {
  static var previews: some View {
    SimilarMovieViewRepresentable()
  }
}
#endif
