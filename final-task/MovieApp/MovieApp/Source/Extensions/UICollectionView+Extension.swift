//
//  UICollectionView+Extension.swift
//  Vega
//
//  Created by rasul on 9/5/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import UIKit

extension UICollectionView {
	func register<T: UICollectionViewCell>(_ :T.Type) {
		register(T.self, forCellWithReuseIdentifier: T.name)
	}
	
	func register<T: UICollectionReusableView>(_ :T.Type) {
		register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.name)
	}
  
  func registerDataSourceDelegate(with dataSource: BasicDataSource) {
    self.dataSource = dataSource
    self.delegate = dataSource
  }
	
	func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
		guard let cell = dequeueReusableCell(withReuseIdentifier: T.name, for: indexPath) as? T else {
			fatalError("Unable to Dequeue Reusable Colellection View Cell")
		}
		return cell
	}
	
	func dequeueReusableHeaderView<T: UICollectionReusableView>(for indexPath: IndexPath) -> T {
		guard let header = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.name, for: indexPath) as? T else {
			fatalError("Could not deque cell with identifier")
		}
		return header
	}
}
