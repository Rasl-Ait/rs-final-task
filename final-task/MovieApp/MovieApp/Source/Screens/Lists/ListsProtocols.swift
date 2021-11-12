//
//  ListsProtocols.swift
//  MovieApp
//
//  Created by rasul on 11/5/21.
//  
//

import Foundation

protocol ListsViewInput: AnyObject {
  func success(items: [ListModel])
  func successCreateList(text: String)
  func successDeleteList(text: String)
  func successAddMovieToList(text: String)
  
  func failure(error: APIError)

  func hideIndicator()
  func showIndicator()
}

protocol ListsViewOutput: AnyObject {
  var lists: [ListModel] { get }
  
  func getLists(state: StateLoad)
  func createList()
  func deleteList(id: Int)
  func didSelectRowAt(list: ListModel)
  func addText(name: String)
  func pop()
}
