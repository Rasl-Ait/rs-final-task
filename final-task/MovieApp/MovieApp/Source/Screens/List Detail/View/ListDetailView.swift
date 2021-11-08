//
//  ListDetailView.swift
//  MovieApp
//
//  Created by rasul on 11/7/21.
//

import UIKit
import SnapKit

final class ListDetailView: UIView {
  
  // MARK: - Properties
  lazy var collectionView = makeCollectionView()
  private lazy var dataSource = configureDataSource()
  
  private var deleteIndexPath: IndexPath!

  // MARK: - Closure
  var didRemoveButton: ItemClosure<Int>?
  
  // MARK: - Overriden funcs
  
  enum Section {
      case all
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func addMovie(_ items: [MovieModel]) {
    updateSnapshot(items)
  }
  
  func removeMovie() {
    guard let list = self.dataSource.itemIdentifier(for: deleteIndexPath) else { return }
    var snapshot = dataSource.snapshot()
    snapshot.deleteItems([list])
    dataSource.apply(snapshot, animatingDifferences: true)
  }
}

// MARK: - Private Extension
private extension ListDetailView {
  func setupView() {
    backgroundColor = .background
    apperance()
    setupLayoutUI()
    
    collectionView.dataSource = dataSource
  }
  
  func apperance() {
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
private extension ListDetailView {
  func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
    let sectionProvider = { (_: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(230))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
       // item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
      
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
      let spacing = CGFloat(20)
      group.interItemSpacing = .fixed(spacing)
      
      let section = NSCollectionLayoutSection(group: group)
      section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
      section.interGroupSpacing = 20
      
      return section
    }
    
    return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
  }
  
  func makeCollectionView() -> UICollectionView {
    let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    view.disableAutoresizingMask()
    view.backgroundColor = .clear
    view.showsVerticalScrollIndicator = false
    view.register(ListDetailCollectionCell.self)
    return view
  }
}

// MARK: - Data Source
private extension ListDetailView {
  func configureDataSource() -> UICollectionViewDiffableDataSource<Section, MovieModel> {
    let dataSource = UICollectionViewDiffableDataSource<Section, MovieModel>(
      collectionView: collectionView) { collectionView, indexPath, model in
      let cell: ListDetailCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
      cell.configure(model: model)
      
      cell.didRemoveButton = { [weak self] in
        guard let self = self else { return }
        self.deleteIndexPath = indexPath
        self.didRemoveButton?(model.id)
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

// MARK: - Constants
extension ListDetailView {
  private enum Constants {
    static let logoTop: CGFloat = .marginXXXL
    static let stackViewLeftRight: CGFloat = .marginL
    static let stackViewTop: CGFloat = .marginL
  }
  
  private enum Size {
    static let imageWidth: CGFloat = 185.0
    static let imageHeight: CGFloat = 134.0
    static let logoWidth: CGFloat = 306.0
    static let logoHeight: CGFloat = 200.0
    static let loginPasswordHeighWidth: CGFloat = 57
  }
  
  private enum CornerRadius {
    static let logoViewRadius: CGFloat = .radiusXXXL
  }
  
  private enum Spacing {
    static let stackView: CGFloat = .spacingL
  }
}

#if DEBUG
import SwiftUI

struct ListDetailViewRepresentable: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    return ListDetailView()
  }
  func updateUIView(_ view: UIView, context: Context) {
    // do your logic here
  }
}

@available(iOS 13.0, *)
struct ListDetailView_Preview: PreviewProvider {
  static var previews: some View {
    ListDetailViewRepresentable()
  }
}
#endif