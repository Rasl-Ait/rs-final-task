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
  lazy var collectionView = makeCollectionView()
  private lazy var dataSource = configureDataSource()
  private lazy var removeButton = makeRemoveButton()
  
  private var deleteIndexPath: IndexPath!
  
  enum Section {
    case all
  }
  
  var presenter: ListDetailViewOutput!
  
  private var isEditingToggle: Bool = false {
    didSet {
      collectionView.delegate = !isEditing ? self : nil
      collectionView.allowsSelection = !isEditing ? true : false
      removeButton.isHidden = !isEditing
    }
  }
  
  // MARK: Overriden funcs
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    configureNavigationBar(isHidden: false, barStyle: .default)
    presenter.getMovies(state: .noRefresh)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }
  
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    editButtonItem.tintColor = !isEditing ? .navigationBarTintColor : .doneButtonColor
    isEditingToggle = isEditing
    if InternetConnection().isConnectedToNetwork() {
      collectionView.allowsSelection = true
      collectionView.indexPathsForVisibleItems.forEach { indexPath in
        guard let cell = collectionView.cellForItem(at: indexPath) as? ListDetailCollectionCell else { return }
        cell.isEditing = isEditing
        
        if !isEditing {
          cell.isSelected = false
        }
      }
      
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
    setupRefresh(collectionView)
    setupLayoutUI()
    isEditingToggle = false
    
    refreshLoadData = { [weak self] in
      guard let self = self else { return }
      if InternetConnection().isConnectedToNetwork() {
        self.refresh()
      }
    }
  }
  
  func setupRefresh(_ collectionView: UICollectionView) {
    let refreshControl = UIRefreshControl()
    collectionView.alwaysBounceVertical = true
    refreshControl.tintColor = .red
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    collectionView.refreshControl = refreshControl
  }
  
  func setupAppearence() {
    view.addSubview(collectionView)
    view.addSubview(removeButton)
  }
  
  func setupLayoutUI() {
    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    removeButton.snp.makeConstraints {
      $0.height.width.equalTo(60)
      $0.bottom.equalToSuperview().inset(40)
      $0.leading.equalToSuperview().offset(15)
    }
  }
  
  func addMovie(_ items: [MovieModel]) {
    updateSnapshot(items, animatingChange: true)
  }
  
  func removeMovie() {
    guard let selectedIndexPaths = collectionView.indexPathsForSelectedItems else { return }
    let movies = selectedIndexPaths.compactMap { dataSource.itemIdentifier(for: $0) }
    var snapshot = dataSource.snapshot()
    snapshot.deleteItems(movies)
    dataSource.apply(snapshot, animatingDifferences: true)
  }
}

// MARK: Setup UI
private extension ListDetailViewController {
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
  
  func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
    let sectionProvider = { (_: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(250.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      // item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
      
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1.0))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
      let spacing = CGFloat(10)
      group.interItemSpacing = .fixed(spacing)
      
      let section = NSCollectionLayoutSection(group: group)
      section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
      section.interGroupSpacing = 10
      
      return section
    }
    
    return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
  }
  
  func makeCollectionView() -> UICollectionView {
    let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    view.backgroundColor = .clear
    view.showsVerticalScrollIndicator = false
    view.register(ListDetailCollectionCell.self)
    return view
  }
  
  func makeRemoveButton() -> UIButton {
    let config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 30))
    let view = CustomButton(.setImage(.delete, configuration: config).withColor(.trashColor), highlightedImage: .setImage(.delete, configuration: config).withColor(#colorLiteral(red: 0.9078176022, green: 0.3331586123, blue: 0.08758335561, alpha: 0.7640920626)))
    view.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
    view.backgroundColor = .cellBackgroundColor
    view.layer.cornerRadius = .radiusXXXL
    view.tintColor = .trashColor
    view.isHidden = true
    return view
  }
  
  func setupEmptyView() {
    let emptyView = EmptyView()
    emptyView.setText(text: "You haven't added any movies yet")
    view.addSubview(emptyView)
    emptyView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
}

// MARK: Action
private extension ListDetailViewController {
  @objc func sortedTapped() {
    Alert.showAlertSheet(on: self, title: "Choose your option", titles: presenter.alertTitles) { alert in
      let sortedType = SortedType(rawValue: alert.title ?? "") ?? .date
      let sortedMovies = self.presenter.sorted(type: sortedType)
      self.updateSnapshot(sortedMovies, animatingChange: true)
    }
  }
  
  // MARK: Action func
  @objc func removeButtonTapped() {
    guard let selectedIndexPaths = collectionView.indexPathsForSelectedItems else { return }
    let movies = selectedIndexPaths.compactMap { dataSource.itemIdentifier(for: $0) }
    
    guard let item = movies.first else { return }
    
    if !selectedIndexPaths.isEmpty {
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
  }
  
  @objc func backTapped() {
    presenter.viewWillDisappear()
  }
  
  @objc func refresh() {
    presenter.getMovies(state: .refresh)
  }
}

// MARK: - Data Source
private extension ListDetailViewController {
  func configureDataSource() -> UICollectionViewDiffableDataSource<Section, MovieModel> {
    let dataSource = UICollectionViewDiffableDataSource<Section, MovieModel>(
      collectionView: collectionView) { collectionView, indexPath, model in
      let cell: ListDetailCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
      cell.configure(model: model)
      return cell
    }
    
    return dataSource
  }
  
  func updateSnapshot(_ items: [MovieModel], animatingChange: Bool = false) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, MovieModel>()
    snapshot.appendSections([.all])
    snapshot.appendItems(items, toSection: .all)
    dataSource.apply(snapshot, animatingDifferences: animatingChange)
  }
}

// MARK: UICollectionViewDelegate
extension ListDetailViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: false)
    guard let movie = self.dataSource.itemIdentifier(for: indexPath) else { return }
    presenter.push(id: movie.id)
  }
}

// MARK: - ListDetailViewInput
extension ListDetailViewController: ListDetailViewInput {
  func successRemoveMovie() {
    hide()
    removeMovie()
  }
  
  func success(items: [MovieModel], state: StateLoad) {
    
    if items.isEmpty {
      hide()
      setupEmptyView()
      return
    }
    
    addMovie(items)
    
    if state == .refresh {
      collectionView.refreshControl?.endRefreshing()
      isEditing = false
    } else {
      hide()
    }
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
