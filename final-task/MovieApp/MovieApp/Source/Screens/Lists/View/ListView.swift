//
//  ListView.swift
//  MovieApp
//
//  Created by rasul on 11/6/21.
//

import UIKit
import SnapKit

protocol ListViewDelegate: AnyObject {
  func fetchItems()
  func openUserDetailsView(row: Int)
}

final class ListView: UIView {
  
  // MARK: - Properties
  private lazy var collectionView = makeCollectionView()
  
  private var dataSource = GenericCollectionDataSource<ListModel, ListCollectionCell>()
  
  // MARK: - Closure
  
  // MARK: - Overriden funcs
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func addList(_ items: [ListModel]) {
    dataSource.addItems(items, in: collectionView)
  }
}

// MARK: - Private Extension
private extension ListView {
  func setupView() {
    backgroundColor = .background
    apperance()
    setupDataSource()
    setupLayoutUI()
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
  func makeFlowLayout() -> UICollectionViewFlowLayout {
    let view = UICollectionViewFlowLayout()
    view.scrollDirection = .vertical
    view.minimumLineSpacing = 20
    view.sectionInset = UIEdgeInsets(topBottom: 20)
    let cellWidth = floor(UIScreen.width - 44)
    let cellHeight: CGFloat = .marginXXXL * 2
    view.itemSize = CGSize(width: cellWidth, height: cellHeight)
    return view
  }
  
  func makeCollectionView() -> UICollectionView {
    let view = UICollectionView(frame: .zero, collectionViewLayout: makeFlowLayout())
    view.disableAutoresizingMask()
    view.backgroundColor = .clear
    view.showsVerticalScrollIndicator = false
    view.register(ListCollectionCell.self)
    return view
  }
}

// MARK: - Data Source
private extension ListView {
  func setupDataSource() {
    dataSource.onConfigureCell = { cell, model in
      cell.configure(model: model)
      return cell
    }
    
    collectionView.registerDataSourceDelegate(with: dataSource)
  }
}

// MARK: Action
private extension ListView {

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
