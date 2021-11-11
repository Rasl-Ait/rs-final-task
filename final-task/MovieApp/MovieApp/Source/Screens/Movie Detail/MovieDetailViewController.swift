//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by rasul on 11/10/21.
//  
//

import UIKit

final class MovieDetailViewController: BaseViewController {
	var presenter: MovieDetailViewOutput!
  
  private lazy var scrollView = makeScrollView()
  private lazy var detailView = makeMovieDetailView()
    
	override func viewDidLoad() {
		super.viewDidLoad()
    setupViews()
	}
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    configureNavigationBar(isHidden: true, barStyle: .default)
  }
}

// MARK: - Private extension
private extension MovieDetailViewController {
  func setupViews() {
    view.backgroundColor = .backgroundColor
    setupAppearence()
    setupLayoutUI()
    presenter.getMovie()
  }
  
  func setupAppearence() {
    scrollView.addSubview(detailView)
    view.addSubview(scrollView)
  }
  
  func setupLayoutUI() {
    scrollView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(-view.safeAreaTop)
      $0.edges.equalToSuperview()
    }
    
    detailView.snp.makeConstraints {
      $0.edges.equalTo(scrollView)
      $0.width.equalTo(view)
    }
  }
}

// MARK: - Setup UI
private extension MovieDetailViewController {
  func makeScrollView() -> UIScrollView {
    let view = UIScrollView()
    view.showsVerticalScrollIndicator = false
    return view
  }
  
  func makeMovieDetailView() -> MovieDetailView {
    let view = MovieDetailView()
    return view
  }
}

// MARK: - Private Extension
extension MovieDetailViewController: MovieDetailViewInput {
  func success(type: DetailContentType) {
    hide()
    detailView.configure(type: type)
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

struct MovieDetailViewControllerRepresentable: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    return MovieDetailViewController().view
  }
  func updateUIView(_ view: UIView, context: Context) {
    // do your logic here
  }
}

@available(iOS 13.0, *)
struct MovieDetailViewController_Preview: PreviewProvider {
  static var previews: some View {
    MovieDetailViewControllerRepresentable()
  }
}
#endif
