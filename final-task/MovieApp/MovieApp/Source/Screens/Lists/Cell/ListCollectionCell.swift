//
//  ListCollectionCell.swift
//  MovieApp
//
//  Created by rasul on 11/6/21.
//

import UIKit

class ListCollectionCell: BaseCollectionViewCell {
  
  // MARK: - Properties
  private lazy var cellView = makeCellView()
  
  // MARK: Closure
  var didRemoveButton: VoidClosure? {
    didSet {
      cellView.didRemoveButton = didRemoveButton
    }
  }
  
  // MARK: Overriden funcs
  override func addSubViews() {
    setupViews()
  }
  
  func configure(model: ListModel) {
    cellView.configure(model)
  }
}

// MARK: - Private ListCollectionCell
private extension ListCollectionCell {
  func setupViews() {
    contentView.addSubview(cellView)
    setupLayoutUI()
  }
  
  func makeCellView() -> ListViewCell {
    let view = ListViewCell()
    return view
  }
  
  func  setupLayoutUI() {
    cellView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

#if DEBUG
import SwiftUI

struct ListCollectionRepresentable: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    return ListCollectionCell()
  }
  func updateUIView(_ view: UIView, context: Context) {
    // do your logic here
  }
}

@available(iOS 13.0, *)
struct ListCollectionController_Preview: PreviewProvider {
  static var previews: some View {
    ListCollectionRepresentable()
  }
}
#endif
