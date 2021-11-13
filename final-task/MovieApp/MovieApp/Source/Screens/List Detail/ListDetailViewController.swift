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
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    configureNavigationBar(isHidden: false, barStyle: .default)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }
  
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    editButtonItem.tintColor = !isEditing ? .navigationBarTintColor : .doneButtonColor
    if InternetConnection().isConnectedToNetwork() {
      listView.setEditing(isEditing: isEditing)
    } else {
      Alert.showAlert(on: self,
                      with: .attention,
                      message: "Removal is available only when the Internet is on") { _ in
        self.isEditing = false
      }
    }
  }
  deinit {
    print("delete vc List detail")
  }
}

// MARK: - Private ListDetailViewController
private extension ListDetailViewController {
  func setupViews() {
    view.backgroundColor = .backgroundColor
    setupConfigureNavigationBar()
    setupAppearence()
    setupRefreshControl(listView.collectionView)
    setupLayoutUI()
    presenter.getMovies(state: .noRefresh)
    
    refreshLoadData = { [weak self] in
      guard let self = self else { return }
      if InternetConnection().isConnectedToNetwork() {
        self.refresh()
      }
    }
    
    listView.didRemoveButton = { [weak self] item in
      guard let self = self else { return }
      Alert.showAlertAction(
        on: self,
        title: .removeMovie,
        message: .none,
        messageText: item.title,
        primaryTitle: .delete) { _ in
        self.presenter.removeMovie(item: item)
        } secondAction: { _ in
      }
    }
    
    listView.didSelectRowAt = { [weak self ] id in
      guard let self = self else { return }
      self.presenter.push(id: id)
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
}

// MARK: Setup UI
private extension ListDetailViewController {
  func makeListDetailView() -> ListDetailView {
    let view = ListDetailView()
    return view
  }
  
  func setupConfigureNavigationBar() {
    navigationItem.title = presenter.title
    navigationController?.navigationBar.prefersLargeTitles = true
    let sortedBarButtonItem = UIBarButtonItem(
      image: .setImage(.arrowDownAndUp),
      style: .plain,
      target: self,
      action: #selector(sortedTapped)
    )
    
    let backBarButtonItem = UIBarButtonItem(image: .setImage(.back),
                                            style: .plain,
                                            target: self,
                                            action: #selector(backTapped))
    navigationItem.rightBarButtonItems = [sortedBarButtonItem, editButtonItem]
    navigationItem.leftBarButtonItem = backBarButtonItem
  }
}

// MARK: Action
private extension ListDetailViewController {
  @objc func sortedTapped() {
    Alert.showAlertSheet(on: self, title: "Choose your option", titles: presenter.alertTitles) { alert in
      let titleType = SortedType(rawValue: alert.title ?? "") ?? .date
      self.listView.sorted(type: titleType)
    }
  }
  
  @objc func backTapped() {
    presenter.viewWillDisappear()
  }
  
  func refresh() {
    presenter.getMovies(state: .refresh)
    listView.collectionView.refreshControl?.endRefreshing()
    isEditing = false
  }
}

// MARK: - ListDetailViewInput
extension ListDetailViewController: ListDetailViewInput {
  func successRemoveMovie() {
    hide()
    listView.removeMovie()
  }
  
  func success(items: [MovieModel]) {
    hide()
    listView.addMovie(items)
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
