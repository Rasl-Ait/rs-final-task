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
}

enum AlertMessageType: String {
  case deleteList = "Delete List?"
  case none = ""
}

enum AlertTitleType: String {
  case warning = "Warning"
  case attention = "Attention"
  case createList = "Created new list"
  case delete = "Delete"
}

enum IconType: String {
  case logo
}

enum SFSymbolConstants: String {
  // tab icons
  case home = "house"
  case movies = "film"
  case search = "magnifyingglass"
  case news = "newspaper"
  case profile = "person.crop.circle"
  
  // Navigation Bar
  case plus = "plus.circle"
  
  // icons used on home screen
  case taskDone = "checkmark"
  case taskToDo = "circle"
  case profileIcon = "person.crop.circle.fill"
  
  // settings icons
  case about = "info.circle"
  case feedback = "square.and.pencil"
  case changePassword = "lock"
  case logout = "power"
  case delete = "trash.circle"
  
  // dismiss sheet button icon
  case xCircle = "x.circle.fill"
  
  // report violation icon
  case reportComment = "exclamationmark.bubble"
  
  // ellipsis icon ("..."). used to show additional controls
  case ellipsis = "ellipsis"
  
}

enum TextFieldType: String {
  case login
  case password
}

enum ScreenType: String {
  case home
  case movies
  case search
  case news
  case profile
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

enum SegmentType: Int {
  case outcome = 0
  case income
}

enum AlertButton: String {
  case cancel = "Cancel"
  case yes = "Yes"
  case delete = "Delete"
}
