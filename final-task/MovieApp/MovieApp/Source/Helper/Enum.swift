//
//  Enum.swift
//  Wallets
//
//  Created by rasul on 9/29/21.
//

import UIKit

enum TextType: String {
  case wallets = "Wallets"
  case editWallet = "Edit wallet"
  case transactions = "Transactions"
  case addTransaction = "Add transaction"
  case editTransaction = "Edit transaction"
  case colorTheme = "Color theme"
  case colorThemes = "Color themes"
  case walletCurrency = "Wallet currency"
  case title = "Title"
  case currency = "Currency"
  case addNewWallet = "Add new wallet"
  case outcome = "Outcome"
  case income = "Income"
  case change = "Change"
  case note = "Note"
  case startHere = "Start here..."
  case typeHere = "Type here..."
  case seeAll = "See all"
  case cancel = "Cancel"
  case warning = "The length of the wallet name must not exceed 20 characters"
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
  case addSelected = "add-selected"
  case add
  case backSelected = "back-selected"
  case back
  case deleteSelected = "delete-selected"
  case delete
  case editSelected = "edit-selected"
  case edit
  case settings
  case settingsSelected = "settings-selected"
  case walletsSelected = "wallets-selected"
  case wallets
  case property1 = "Property1"
  case property2 = "Property2"
  case property3 = "Property3"
  case property4 = "Property4"
  case property5 = "Property5"
}

enum ScreenType: String {
  case wallets
  case transactions
  case addTrancaction
  case editTransactions
  case edit
  case color
  case walletCurrency
  case editWallet
  case addNewWallet
  case wallet
}

enum DateFormatType: String {
  case MMMM_dd_yyyy = "MMMM dd, yyyy"
  case d_MMM = "d MMM"
}

enum FontSize: CGFloat {
  case font24 = 24.0
  case font18 = 18.0
  case font14 = 14.0
  case font16 = 16.0
  case font36 = 36.0
  case font48 = 48.0
  case font17 = 17.0
  case font20 = 20.0
}

enum ActionType {
  case create
  case remove
  case edit
  case none
}

enum TransactionType {
  case title(String)
  case amount(Int)
  case note(String)
}

enum WalletContainerButtonType {
  case all
  case add
  case cell(Int)
}

enum BlockType {
  case color
  case currency
}

enum SaveDataType {
  case edit
  case add
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
