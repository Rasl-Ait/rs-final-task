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
  private lazy var listView = makeListView()
  
	var presenter: ListsViewOutput!
    
	override func viewDidLoad() {
		super.viewDidLoad()
    setupViews()
	}
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    configureNavigationBar(isHidden: false, barStyle: .default)
    presenter.getLists(state: .noRefresh)
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
    
    listView.didRemoveButton = { [weak self] id in
      guard let self = self else { return }
      
      if InternetConnection().isConnectedToNetwork() {
        Alert.showAlertAction(on: self, title: .delete, message: .deleteList, primaryTitle: .delete) { _ in
          self.presenter.deleteList(id: id)
        } secondAction: { _ in
        }
      } else {
        Alert.showAlert(on: self,
                        with: .attention,
                        message: .removeMovieFailure) { _ in

        }
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
    navigationItem.title = ScreenTitle.lists.title
    let config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 30))
    let plusBarButtonItem = UIBarButtonItem(image: .setImage(.plus, configuration: config),
                                            style: .plain,
                                            target: self,
                                            action: #selector(plusTapped))
    let logoutBarButtonItem = UIBarButtonItem(image: .setImage(.logout),
                                              style: .plain,
                                              target: self,
                                              action: #selector(logoutTapped))
    
    navigationItem.rightBarButtonItem = plusBarButtonItem
    
    if presenter.mediaID == nil {
      navigationItem.leftBarButtonItem = logoutBarButtonItem
    }
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
    
    if InternetConnection().isConnectedToNetwork() {
      Alert.showAlertText(on: self,
                          title: .createList,
                          text: .none,
                          placeholder: TextType.newList.rawValue,
                          editingChangedTarget: self,
                          editingChangedSelector: #selector(alertTextFieldValueChanged(textField:))) { _ in
        self.presenter.createList()
      } secondAction: { _ in
        
      }
    } else {
      Alert.showAlert(on: self,
                      with: .attention,
                      message: .createNewListFailure) { _ in

      }
    }
  }
  
  @objc func alertTextFieldValueChanged(textField: UITextField) {
    guard let text = textField.text else {
      Alert.showAlert(on: self, with: .attention, message: .newListNameFailure)
      return
    }
    presenter.addText(name: text)
  }
  
  @objc func logoutTapped() {
    Alert.showAlertAction(on: self, title: .attention,
                          message: .logout,
                          messageText: nil,
                          primaryTitle: .yes,
                          secondTitle: .cancel,
                          preferredStyle: .alert) { _ in
      self.presenter.logout()
    } secondAction: { _ in
      
    }

  }
}

// MARK: - Setup UI
private extension ListsViewController {
  func makeListView() -> ListView {
    let view = ListView()
    return view
  }
  
  func setupEmptyView() {
    let emptyView = EmptyView()
    emptyView.setText(text: .listEmpty)
    view.addSubview(emptyView)
    emptyView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
}

// MARK: - ListsViewInput
extension ListsViewController: ListsViewInput {
  func successAddMovieToList(text: String) {
    hide()
    Alert.showAlert(on: self, with: .successfully, message: text) { _ in
      self.presenter.pop()
    }
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
    if items.isEmpty {
      hide()
      setupEmptyView()
      return
    }
    
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
