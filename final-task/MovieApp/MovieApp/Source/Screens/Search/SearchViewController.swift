//
//  SearchViewController.swift
//  MovieApp
//
//  Created by rasul on 11/12/21.
//  
//

import UIKit

final class SearchViewController: BaseViewController {
  
  
	var presenter: SearchViewOutput!
    
	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension SearchViewController: SearchViewInput {
	func success() {}
	func failure(error: APIError) {}
	func hideIndicator() {}
	func showIndicator() {}
}

#if DEBUG
import SwiftUI

struct SearchViewRepresentable: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    return SearchViewController().view
  }
  func updateUIView(_ view: UIView, context: Context) {
    // do your logic here
  }
}

@available(iOS 13.0, *)
struct SearchViewController_Preview: PreviewProvider {
  static var previews: some View {
    SearchViewRepresentable()
  }
}
#endif
