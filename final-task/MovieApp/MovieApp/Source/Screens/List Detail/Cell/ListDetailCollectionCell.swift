//
//  ListDetailCollectionCell.swift
//  MovieApp
//
//  Created by rasul on 11/7/21.
//

import UIKit

final class ListDetailCollectionCell: BaseCollectionViewCell {
  
  // MARK: - Properties
  private lazy var cellView = makeCellView()
  
  // MARK: Closure
  var didRemoveButton: VoidClosure? {
    didSet {
      cellView.didRemoveButton = didRemoveButton
    }
  }
  
  // MARK: Overriden
  
  var isEditing: Bool = false {
    didSet {
      cellView.isEditing(isEditing: isEditing)
    }
  }
  
  override var isSelected: Bool {
    didSet {
      cellView.isSelected(isSelected: isSelected)
    }
  }
  
  override func addSubViews() {
    setupViews()
  }
  
  override func prepareForReuse() {
    cellView.prepareForReuse()
  }
  
  func configure(model: MovieModel) {
    cellView.configure(model)
  }
}

// MARK: - Private ListDetailCollectionCell
private extension ListDetailCollectionCell {
  func setupViews() {
    contentView.addSubview(cellView)
    setupLayoutUI()
  }
  
  func makeCellView() -> ListDetailCollectionCellView {
    let view = ListDetailCollectionCellView()
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

struct ListDetailCollectionRepresentable: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    return ListDetailCollectionCell()
  }
  func updateUIView(_ view: UIView, context: Context) {
    // do your logic here
  }
}

@available(iOS 13.0, *)
struct ListDetailCollectionController_Preview: PreviewProvider {
  static var previews: some View {
    ListDetailCollectionRepresentable()
  }
}
#endif
