//
//  ListsViewController.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//  
//

import UIKit

enum StateLoad {
  case refresh
  case noRefresh
}

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
    view.backgroundColor = .backgroundColor
    configureNavigationBar()
    setupAppearence()
    setupRefreshControl(listView.collectionView)
    setupLayoutUI()
    presenter.getLists(state: .noRefresh)
    
    listView.didRemoveButton = { [weak self] id in
      guard let self = self else { return }
      Alert.showAlertAction(on: self, title: .delete, message: .deleteList, primaryTitle: .delete) { _ in
        self.presenter.deleteList(id: id)
      } secondAction: { _ in
      }
    }
    
    listView.didSelectRowAt = { [weak self] item in
      guard let self = self else { return }
      self.presenter.didSelectRowAt(list: item)
    }
    
    refreshLoadData = { [weak self] in
      guard let self = self else { return }
      self.presenter.getLists(state: .refresh)
      self.listView.collectionView.refreshControl?.endRefreshing()
    }
  }
  
  func configureNavigationBar() {
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.title = "Lists"
    let config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 30))
    let plusBarButtonItem = UIBarButtonItem(image: .setImage(.plus, configuration: config), style: .plain, target: self, action: #selector(plusTapped))
    navigationItem.rightBarButtonItem = plusBarButtonItem
  }
  
  func setupAppearence() {
    view.addSubview(listView)
  }
  
  func setupLayoutUI() {
    listView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }

  // MARK: - Action funcs
  @objc func plusTapped() {
    Alert.showAlertText(on: self,
                        title: .createList,
                        text: .none,
                        placeholder: TextType.newList.rawValue,
                        editingChangedTarget: self,
                        editingChangedSelector: #selector(alertTextFieldValueChanged(textField:))) { _ in
      self.presenter.createList()
    } secondAction: { _ in
      
    }
  }
  
  @objc func alertTextFieldValueChanged(textField: UITextField) {
    guard let text = textField.text else {
      Alert.showAlert(on: self, with: .attention, message: "Provide a name for the new list")
      return
    }
    presenter.addText(name: text)
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
  func successAddMovieToList(text: String) {
    hide()
    Alert.showAlert(on: self, with: .successfully, message: text)
  }
  
  func successDeleteList(text: String) {
    hide()
    Alert.showAlert(on: self, with: .attention, message: text) { _ in
      self.listView.removeList()
    }
  }
  
  func successCreateList(text: String) {
    hide()
    presenter.getLists(state: .noRefresh)
  }
  
  func success(items: [ListModel]) {
    hide()
    listView.addList(items)
  }
  
	func failure(error: APIError) {
    hide()
    Alert.showAlert(on: self, with: .warning, message: error.localizedDescription)
  }
  
	func hideIndicator() {
    hide()
  }
	func showIndicator() {
    show()
  }
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
