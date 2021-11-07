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
    
    listView.didRemoveButton = { [weak self] id in
      guard let self = self else { return }
      Alert.showAlertAction(on: self, title: .delete, message: .deleteList, primaryTitle: .delete) { _ in
        self.presenter.deleteList(id: id)
      } secondAction: { _ in
      }
    }
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
  func successDeleteList(text: String) {
    hide()
    Alert.showAlert(on: self, with: .attention, message: text) { _ in
      self.listView.removeList()
    }
  }
  
  func successCreateList(text: String) {
    hide()
    presenter.getLists()
  }
  
  func success(items: [ListModel]) {
    hide()
    listView.addList(items)
  }
	func failure(error: Error) {
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
