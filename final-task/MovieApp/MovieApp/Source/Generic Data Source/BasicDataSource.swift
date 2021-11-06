//
//  BasicDataSource.swift
//  Wallets
//
//  Created by rasul on 10/3/21.
//

import UIKit

class BasicDataSource: NSObject {
  
  func numberOfItems(in section: Int) -> Int {
    fatalError("\(self): \(#function) Should be implemented to get the number of item in section")
  }
  
  func getCollectionViewCell(in collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
    fatalError("\(self): \(#function) Should be implemented to get the collectionView cell")
  }
  
  func getCellHeight(_ indexPath: IndexPath) -> CGFloat {
    return 80
  }
}

extension BasicDataSource: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    numberOfItems(in: section)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    getCollectionViewCell(in: collectionView, indexPath: indexPath)
  }
}

extension BasicDataSource: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath) {}
  
  func collectionView(
    _ collectionView: UICollectionView,
    didDeselectItemAt indexPath: IndexPath) {}
}
