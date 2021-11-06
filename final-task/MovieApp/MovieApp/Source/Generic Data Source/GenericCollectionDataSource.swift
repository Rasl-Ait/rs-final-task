//
//  GenericCollectionDataSource.swift
//  Wallets
//
//  Created by rasul on 10/3/21.
//

import UIKit

protocol GenericDataSourceProtocol {
  associatedtype Item
  var items: [Item] { get set }
}

class GenericCollectionDataSource<ItemType, CellType: UICollectionViewCell>: BasicDataSource, GenericDataSourceProtocol {

  typealias CellConfiguration = ((_ cell: CellType, _ item: ItemType) -> CellType)
  
  var items: [ItemType] = []
  var onConfigureCell: CellConfiguration?
  var onDidSelectCell: ItemClosure<Int>?
  var onDidDeselectCell: ItemClosure<Int>?
  
  func addItems(_ items: [ItemType], in collectionView: UICollectionView) {
    guard !items.isEmpty else {
      return
    }
    
    self.items = items
    let range = 0...items.count - 1
    let indices = range.map {
      IndexPath(row: $0, section: 0)
    }
    
    UIView.performWithoutAnimation {
      collectionView.insertItems(at: indices)
    }
  }
  
  func replaceItem(_ item: ItemType, indexPath: IndexPath, collectionView: UICollectionView) {
    items[indexPath.item] = item
    UIView.performWithoutAnimation {
      collectionView.reloadItems(at: [indexPath])
    }
  }
  
  func appendItem(_ item: ItemType, collectionView: UICollectionView) {
    items.insert(item, at: 0)
    let indexPath = IndexPath(row: 0, section: 0)
    UIView.performWithoutAnimation {
      collectionView.insertItems(at: [indexPath])
    }
  }
  
  func removeItem(_ index: Int, collectionView: UICollectionView) {
    items.remove(at: index)
    let indexPath = IndexPath(row: index, section: 0)
    UIView.performWithoutAnimation {
      collectionView.deleteItems(at: [indexPath])
    }
  }
  
  override func numberOfItems(in section: Int) -> Int {
    items.count
  }
  
  override func getCollectionViewCell(in collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
    let cell: CellType = collectionView.dequeueReusableCell(for: indexPath)
    let model = items[indexPath.item]
    return onConfigureCell?(cell, model) ?? UICollectionViewCell()
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    onDidSelectCell?(indexPath.item)
  }
  
  override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    onDidDeselectCell?(indexPath.item)
  }
}
