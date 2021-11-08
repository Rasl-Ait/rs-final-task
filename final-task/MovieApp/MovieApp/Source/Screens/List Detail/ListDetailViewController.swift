//
//  ListDetailViewController.swift
//  MovieApp
//
//  Created by rasul on 11/7/21.
//  
//

import UIKit

final class ListDetailViewController: BaseViewController {
    
  // MARK: - Properties
  private lazy var listView = makeListDetailView()
  
  var presenter: ListDetailViewOutput!
  
  // MARK: Overriden funcs
	override func viewDidLoad() {
		super.viewDidLoad()
    setupViews()
	}
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    presenter.viewWillDisappear()
  }
  
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    editButtonItem.tintColor = !isEditing ? .titleColor : .cellTitle
    listView.setEditing(isEditing: isEditing)
  }
  
  deinit {
    print("delete vc List detail")
  }
}

// MARK: - Private ListDetailViewController
private extension ListDetailViewController {
  func setupViews() {
    view.backgroundColor = .background
    setupConfigureNavigationBar()
    apperance()
    setupRefreshControl(listView.collectionView)
    setupLayoutUI()
    presenter.getMovies(state: .noRefresh)
    
    refreshLoadData = { [weak self] in
      guard let self = self else { return }
      self.presenter.getMovies(state: .refresh)
      self.listView.collectionView.refreshControl?.endRefreshing()
    }
    
    listView.didRemoveButton = { [weak self] item in
      guard let self = self else { return }
      Alert.showAlertAction(
        on: self,
        title: .removeMovie,
        message: .none,
        messageText: item.title,
        primaryTitle: .delete) { _ in
        self.presenter.removeMovie(id: item.id)
      } secondAction: { _ in
      }
    }
  }
  
  func apperance() {
    view.addSubview(listView)
  }
  
  func setupLayoutUI() {
    listView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

// MARK: Setup UI
private extension ListDetailViewController {
  func makeListDetailView() -> ListDetailView {
    let view = ListDetailView()
    return view
  }
  
  func setupConfigureNavigationBar() {
    navigationItem.title = presenter.title
    let sortedBarButtonItem = UIBarButtonItem(
      image: .setImage(.arrowDownAndUp),
      style: .plain,
      target: self,
      action: #selector(sortedTapped)
    )
    
    navigationItem.rightBarButtonItems = [sortedBarButtonItem, editButtonItem]
  }
}

// MARK: Action
private extension ListDetailViewController {
  @objc func sortedTapped() {
    Alert.showAlertSheet(on: self, title: "Choose your option", titles: presenter.alertTitles) { alert in

    }
  }
}

// MARK: - ListDetailViewInput
extension ListDetailViewController: ListDetailViewInput {
  func successRemoveMovie() {
    hide()
    listView.removeMovie()
  }
  
  func successDeleteList(text: String) {
    hide()
//    Alert.showAlert(on: self, with: .attention, message: text) { _ in
//      self.listView.removeList()
//    }
  }
  
  func successCreateList(text: String) {
    hide()
      // presenter.getLists()
  }
  
  func success(items: [MovieModel]) {
    hide()
    listView.addMovie(items)
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

struct ListDetailViewControllerRepresentable: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    return ListDetailViewController().view
  }
  func updateUIView(_ view: UIView, context: Context) {
    // do your logic here
  }
}

@available(iOS 13.0, *)
struct ListDetailViewControllerController_Preview: PreviewProvider {
  static var previews: some View {
    ListDetailViewControllerRepresentable()
  }
}
#endif
