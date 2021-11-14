//
//  FavoriteView.swift
//  MovieApp
//
//  Created by rasul on 11/12/21.
//

import UIKit

enum FavoriteTappedType {
  case cell(Int)
  case favorite(Int)
}

final class FavoriteView: UIView {
  
  // MARK: - Properties
  lazy var collectionView = makeCollectionView()
  private lazy var dataSource = configureDataSource()
  
  private var selectIndexPath: IndexPath!
  private var movies: [MovieModel] = []
  
  enum Section {
    case all
  }
  
  // MARK: - Closure
  var didSelect: ItemClosure<FavoriteTappedType>?
  
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
  
  func removeFavorite() {
    guard let movie = self.dataSource.itemIdentifier(for: selectIndexPath) else { return }
    var snapshot = dataSource.snapshot()
    snapshot.deleteItems([movie])
    dataSource.apply(snapshot, animatingDifferences: true)
  }
}

// MARK: - Private Extension
private extension FavoriteView {
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
}

// MARK: - Setup UI
private extension FavoriteView {
  func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
    let sectionProvider = { (_: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      // item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
      
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1.0))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
      let spacing = CGFloat(10)
      group.interItemSpacing = .fixed(spacing)
      
      let section = NSCollectionLayoutSection(group: group)
      section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
      section.interGroupSpacing = 10
      
      return section
    }
    
    return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
  }
  
  func makeCollectionView() -> UICollectionView {
    let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    view.backgroundColor = .clear
    view.delegate = self
    view.showsVerticalScrollIndicator = false
    view.register(ListDetailCollectionCell.self)
    return view
  }
}

// MARK: - Data Source
private extension FavoriteView {
  func configureDataSource() -> UICollectionViewDiffableDataSource<Section, MovieModel> {
    let dataSource = UICollectionViewDiffableDataSource<Section, MovieModel>(
      collectionView: collectionView) { collectionView, indexPath, model in
      let cell: ListDetailCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
      cell.configure(model: model, type: .favorite)
      
      cell.didSelectFavorite = { [weak self] in
        guard let self = self else { return }
        self.selectIndexPath = indexPath
        self.didSelect?(.favorite(model.id))
      }
      
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
extension FavoriteView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: false)
    guard let movie = self.dataSource.itemIdentifier(for: indexPath) else { return }
    didSelect?(.cell(movie.id))
  }
}

// MARK: - Constants
extension FavoriteView {
  private enum Spacing {
    static let section: CGFloat = .spacingL
  }
}

#if DEBUG
import SwiftUI

struct FavoriteViewwRepresentable: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    return FavoriteView()
  }
  func updateUIView(_ view: UIView, context: Context) {
    // do your logic here
  }
}

@available(iOS 13.0, *)
struct FavoriteView_Preview: PreviewProvider {
  static var previews: some View {
    FavoriteViewwRepresentable()
  }
}
#endif
