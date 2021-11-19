//
//  FavoriteViewController.swift
//  MovieApp
//
//  Created by rasul on 11/12/21.
//  
//

import UIKit

final class FavoriteViewController: BaseViewController {
  
  // MARK: - Properties
  private lazy var collectionView = makeCollectionView()
  private lazy var dataSource = configureDataSource()
  
  private var selectIndexPath: IndexPath!
  
	var presenter: FavoriteViewOutput!
  
  enum Section {
    case all
  }
    
	override func viewDidLoad() {
		super.viewDidLoad()
    setupViews()
	}
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.getFavoriteMovie(state: .noRefresh)
  }
}

// MARK: - Private Extension
private extension FavoriteViewController {
  func setupViews() {
    configureNavigationBar()
    setupAppearence()
    setupLayoutUI()
    setupRefreshControl(collectionView)
    
    refreshLoadData = { [weak self] in
      guard let self = self else { return }
      if InternetConnection().isConnectedToNetwork() {
        self.refresh()
      }
    }
  }
  
  func setupAppearence() {
    view.addSubview(collectionView)
  }

  func setupLayoutUI() {
    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  func configureNavigationBar() {
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.title = "Favorite"
  }
  
  func addMovie(_ items: [MovieModel]) {
    updateSnapshot(items, animatingChange: true)
  }
  
  func removeFavorite() {
    guard let movie = self.dataSource.itemIdentifier(for: selectIndexPath) else { return }
    var snapshot = dataSource.snapshot()
    snapshot.deleteItems([movie])
    dataSource.apply(snapshot, animatingDifferences: true)
  }
  
  @objc func refresh() {
    presenter.getFavoriteMovie(state: .refresh)
  }
}

// MARK: - Setup UI
private extension FavoriteViewController {
  func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
    let sectionProvider = { (_: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1.0))
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
    view.delegate = self
    view.showsVerticalScrollIndicator = false
    view.register(ListDetailCollectionCell.self)
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

// MARK: - Data Source
private extension FavoriteViewController {
  func configureDataSource() -> UICollectionViewDiffableDataSource<Section, MovieModel> {
    let dataSource = UICollectionViewDiffableDataSource<Section, MovieModel>(
      collectionView: collectionView) { collectionView, indexPath, model in
      let cell: ListDetailCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
      cell.configure(model: model, type: .favorite)
      cell.didSelectFavorite = { [weak self] in
        guard let self = self else { return }
        
        if InternetConnection().isConnectedToNetwork() {
          self.selectIndexPath = collectionView.indexPath(for: cell)
          self.presenter.didSelect(type: .favorite(model.id))
        } else {
          Alert.showAlert(
            on: self,
            with: .attention,
            message: "Removal is available only when the Internet is on") { _ in
            
          }
        }
      }
      
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
extension FavoriteViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: false)
    guard let movie = self.dataSource.itemIdentifier(for: indexPath) else { return }
    presenter.didSelect(type: .cell(movie.id))
  }
}

// MARK: FavoriteViewInput
extension FavoriteViewController: FavoriteViewInput {
  func success(items: [MovieModel], state: StateLoad) {
    if items.isEmpty {
      hide()
      setupEmptyView()
      return
    }
    
    addMovie(items)
   
    if state == .refresh {
      collectionView.refreshControl?.endRefreshing()
    } else {
      hide()
    }
  }
  
  func successDeleteMovie() {
    removeFavorite()
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
