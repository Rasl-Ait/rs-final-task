//
//  ListsViewController.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//  
//

import UIKit

final class ListsViewController: BaseViewController {
  
  // MARK: - Properties
  lazy var listView = makeListView()
  
	var presenter: ListsViewOutput!
    
	override func viewDidLoad() {
		super.viewDidLoad()
    setupViews()
	}
}

// MARK: - ListsViewController
private extension ListsViewController {
  func setupViews() {
    view.backgroundColor = .background
    configureNavigationBar()
    apperance()
    setupLayoutUI()
    presenter.getLists()
  }
  
  func configureNavigationBar() {
    navigationItem.title = "Lists"
    let config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 30))
    let plusBarButtonItem = UIBarButtonItem(image: .setImage(.plus, configuration: config), style: .plain, target: self, action: #selector(plusTapped))
    navigationItem.rightBarButtonItem = plusBarButtonItem
  }
  
  func setupLayoutUI() {
    listView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  func apperance() {
    view.addSubview(listView)
  }
  
  // MARK: - Action funcs
  @objc func plusTapped() {
    print(#function)
  }
}

// MARK: - Setup UI
private extension ListsViewController {
  func makeListView() -> ListView {
    let view = ListView()
    return view
  }
}

// MARK: - ListsViewInput
extension ListsViewController: ListsViewInput {
  func success(items: [ListModel]) {
    listView.addList(items)
  }
	func failure(error: Error) {}
	func hideIndicator() {}
	func showIndicator() {}
}

#if DEBUG
import SwiftUI

struct ListsViewRepresentable: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    return ListsViewController().view
  }
  func updateUIView(_ view: UIView, context: Context) {
    // do your logic here
  }
}

@available(iOS 13.0, *)
struct ListsViewController_Preview: PreviewProvider {
  static var previews: some View {
    ListsViewRepresentable()
  }
}
#endif
