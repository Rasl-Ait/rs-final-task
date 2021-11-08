//
//  ListView.swift
//  MovieApp
//
//  Created by rasul on 11/6/21.
//

import UIKit
import SnapKit

final class ListView: UIView {
  
  // MARK: - Properties
  lazy var collectionView = makeCollectionView()
  private lazy var dataSource = configureDataSource()
  
  private var deleteIndexPath: IndexPath!

  // MARK: - Closure
  var didRemoveButton: ItemClosure<Int>?
  var didSelectRowAt: ItemClosure<ListModel>?
  
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
  
  func addList(_ items: [ListModel]) {
    updateSnapshot(items)
  }
  
  func removeList() {
    guard let list = self.dataSource.itemIdentifier(for: deleteIndexPath) else { return }
    var snapshot = dataSource.snapshot()
    snapshot.deleteItems([list])
    dataSource.apply(snapshot, animatingDifferences: true)
  }
}

// MARK: - Private Extension
private extension ListView {
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
private extension ListView {
  func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
    let sectionProvider = { (_: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(.marginXXXL * 2.2))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      // item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
      
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1))
      let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
      
      let section = NSCollectionLayoutSection(group: group)
      section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
      section.interGroupSpacing = 20
      
      return section
    }
    
    return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
  }
  
  func makeCollectionView() -> UICollectionView {
    let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    view.delegate = self
    view.disableAutoresizingMask()
    view.backgroundColor = .clear
    view.showsVerticalScrollIndicator = false
    view.register(ListCollectionCell.self)
    return view
  }
}

// MARK: - Data Source
private extension ListView {
  func configureDataSource() -> UICollectionViewDiffableDataSource<Section, ListModel> {
    let dataSource = UICollectionViewDiffableDataSource<Section, ListModel>(
      collectionView: collectionView) { collectionView, indexPath, model in
      let cell: ListCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
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
  
  func updateSnapshot(_ items: [ListModel], animatingChange: Bool = false) {
      var snapshot = NSDiffableDataSourceSnapshot<Section, ListModel>()
      snapshot.appendSections([.all])
      snapshot.appendItems(items, toSection: .all)
   
      dataSource.apply(snapshot, animatingDifferences: false)
  }
}

// MARK: UICollectionViewDelegate
extension ListView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let list = self.dataSource.itemIdentifier(for: indexPath) else { return }
    didSelectRowAt?(list)
  }
}

// MARK: - Constants
extension ListView {
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

struct ListViewRepresentable: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    return ListView()
  }
  func updateUIView(_ view: UIView, context: Context) {
    // do your logic here
  }
}

@available(iOS 13.0, *)
struct ListView_Preview: PreviewProvider {
  static var previews: some View {
    ListViewRepresentable()
  }
}
#endif
