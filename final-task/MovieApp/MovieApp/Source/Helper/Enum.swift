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
}

enum AlertMessageType: String {
  case changeWallet = "Save changes?"
  case saveNewWallet = "Save new wallet"
  case removeWallet = "Want to delete the wallet?"
  case changeTransaction = "Save changes transaction?"
  case saveNewTransaction = "Save new transaction"
  case removeTransaction = "Want to delete the transaction?"
  case wallet = "Cancel wallet creation or continue?"
  case transaction = "Cancel Transaction creation or continue?"
  case none = ""
}

enum AlertTitleType: String {
  case warning = "Warning"
  case attention = "Attention"
  case walletsTitle = "Wallet name field cannot be empty"
  case walletExists = "A wallet with the same name already exists"
  case note = "Note length must not exceed 250 characters"
  case transactionTitle = "The length of the transaction name must not exceed 20 characters"
  case transactionTitleEmpty = "Transaction name field cannot be empty"
  case transactionValue = "Transaction value must be non-zero"
}

enum IconType: String {
  case logo
}

enum TextFieldType: String {
  case login
  case password
}

//enum ScreenType: String {
//}

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
  case uid(String)
  case title(String)
}

enum SegmentType: Int {
  case outcome = 0
  case income
}

enum AlertButton: String {
  case aContinue = "Continue"
  case yes = "Yes"
}
