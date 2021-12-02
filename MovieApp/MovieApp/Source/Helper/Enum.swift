//
//  Enum.swift
//  Wallets
//
//  Created by rasul on 9/29/21.
//

import UIKit

enum TextType: String {
  case login
  case password
  case signIn = "Sign In"
  case newList = "Enter new list"
  case listEmpty = "You haven't added any list yet"
  case movieEmpty = "You haven't added any movies yet"
}

enum AlertMessageType: String {
  case deleteList = "Delete List?"
  case logout = "Want to get out?"
  case none = ""
  case removeMovieFailure = "Removal is available only when the Internet is on"
  case createNewListFailure = "Creating a new sheet is only available when the web is turned on"
  case newListNameFailure = "Provide a name for the new list"
}

enum AlertTitleType: String {
  case successfully = "Successfully"
  case warning = "Warning"
  case attention = "Attention"
  case createList = "Created new list"
  case delete = "Delete"
  case removeMovie = "Remove Movie"
}

enum IconType: String {
  case logo
}

enum SFSymbolConstants: String {
  // tab icons
  case home = "house"
  case movies = "film"
  case search = "magnifyingglass"
  case profile = "person.crop.circle"
  
  // Navigation Bar
  case plus = "plus.circle"
  case arrowDownAndUp = "arrow.up.arrow.down"
  case back = "arrow.backward"
  case logout = "power"
  
  // WebView
  case arrowClockwise = "arrow.clockwise"
  case safari
  case checkmarkCircle = "checkmark.circle"
  case chevronLeft = "chevron.left"
  case chevronRight = "chevron.right"
  case shareAndArrowUp = "square.and.arrow.up"

  case taskDone = "checkmark"
  case circle = "circle"
  case profileIcon = "person.crop.circle.fill"
  case circleSelect = "circle.circle.fill"
  
  case close = "xmark"
  case info = "info.circle"
  case list = "list.bullet.rectangle"
  case heart = "heart"
  case heartFill = "heart.fill"
  case star = "star"

  case delete = "trash.circle"
  
}

enum TextFieldType: String {
  case login
  case password
}

enum ScreenType: String {
  case home
  case movies
  case search
  case favorite
  case profile
  case movieDetail
}

enum StateLoad {
  case refresh
  case noRefresh
}

enum DateFormatType: String {
  case MMMM_dd_yyyy = "MMMM dd, yyyy"
  case d_MMM = "d MMM"
}

enum ActionType {
  case create
  case remove
  case edit
  case none
}

enum PredicateType {
  case uid(Int)
}

enum AlertButton: String {
  case cancel = "Cancel"
  case yes = "Yes"
  case delete = "Delete"
}

enum SortedType: String {
  case popular = "Popular"
  case date = "Date"
  case rate = "Rate"
}

enum FavoriteTappedType {
  case cell(Int)
  case favorite(Int)
}

enum TabBarItem: Int {
  case home
  case search
  case favorite
}

enum ScreenTitle {
  case lists
  case search
  case favorite
  
  var title: String {
    switch self {
    case.lists:
      return "Lists"
    case .search:
      return "Search"
    case .favorite:
      return "Favorite"
    }
  }
}

enum TextPlaceholder {
  case search
  
  var placeholder: String {
    switch self {
    case .search:
      return "Search for a movie"
    }
  }
}
