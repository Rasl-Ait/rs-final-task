//
//  SearchView.swift
//  MovieApp
//
//  Created by rasul on 11/12/21.
//

import UIKit

final class SearchView: UIView {
  
  // MARK: - Properties
  lazy var collectionView = makeCollectionView()
  private lazy var dataSource = configureDataSource()
  
  private var deleteIndexPath: IndexPath!
  private var movies: [MovieModel] = []
  private var isFetching = false
  
  enum Section {
    case all
  }
  
  // MARK: - Closure
  var didSelectRowAt: ItemClosure<Int>?
  var load: VoidClosure?
  
  // MARK: - Overriden funcs
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func addMovie(_ items: [MovieModel], isFetching: Bool) {
    self.isFetching = isFetching
    self.movies = items
    updateSnapshot(items, animatingChange: true)
  }
}

// MARK: - Private Extension
private extension SearchView {
  func setupView() {
    backgroundColor = .backgroundColor
    setupAppearence()
    setupLayoutUI()
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
private extension SearchView {
  func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
    let sectionProvider = { (_: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      // item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
      
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1.0))
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
    view.backgroundColor = .clear
    view.delegate = self
    view.showsVerticalScrollIndicator = false
    view.register(ListDetailCollectionCell.self)
    return view
  }
}

// MARK: - Data Source
private extension SearchView {
  func configureDataSource() -> UICollectionViewDiffableDataSource<Section, MovieModel> {
    let dataSource = UICollectionViewDiffableDataSource<Section, MovieModel>(
      collectionView: collectionView) { collectionView, indexPath, model in
      let cell: ListDetailCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
      cell.configure(model: model, type: .search)
      return cell
    }
    
    return dataSource
  }
  
  func updateSnapshot(_ items: [MovieModel], animatingChange: Bool = false) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, MovieModel>()
    snapshot.appendSections([.all])
    snapshot.appendItems(items, toSection: .all)
    
    dataSource.apply(snapshot, animatingDifferences: animatingChange)
  }
}

// MARK: UICollectionViewDelegate
extension SearchView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: false)
    guard let movie = self.dataSource.itemIdentifier(for: indexPath) else { return }
    didSelectRowAt?(movie.id)
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    print(indexPath.item)
    if indexPath.row == movies.count - 1 && !isFetching {
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        self.load?()
      }
    }
  }
}

// MARK: - Constants
extension SearchView {
  private enum Spacing {
    static let section: CGFloat = .spacingL
  }
}

#if DEBUG
import SwiftUI

struct SearchViewwRepresentable: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    return SearchView()
  }
  func updateUIView(_ view: UIView, context: Context) {
    // do your logic here
  }
}

@available(iOS 13.0, *)
struct SearchView_Preview: PreviewProvider {
  static var previews: some View {
    SearchViewwRepresentable()
  }
}
#endif
