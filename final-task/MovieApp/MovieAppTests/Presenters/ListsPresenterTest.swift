//
//  ListsPresenterTest.swift
//  MovieAppTests
//
//  Created by rasul on 11/13/21.
//

import XCTest
@testable import MovieApp

class AccountAndListServiceSpy: AccountAndListService {
  
  var responseList: ListResponce?
  var responseNewList: NewListResponce?
  var responseSuccessError: SuccessErrorModel?
  var responseAccount: AccountModel?
  
  override func getAccount(_ completion: @escaping CompletionBlock<AccountModel>) {
    if let response = responseAccount {
      completion(.success(response))
    } else {
      let error = NSError(domain: "", code: 0, userInfo: nil)
      completion(.failure(.requestError(0, error.localizedDescription)))
    }
  }
  
  override func getLists(_ page: Int, completion: @escaping CompletionBlock<ListResponce>) {
    if let response = responseList {
      completion(.success(response))
    } else {
      let error = NSError(domain: "", code: 0, userInfo: nil)
      completion(.failure(.requestError(0, error.localizedDescription)))
    }
  }
  
  override func createList(_ param: NewListParam, completion: @escaping CompletionBlock<NewListResponce>) {
    if let response = responseNewList {
      completion(.success(response))
    } else {
      let error = NSError(domain: "", code: 0, userInfo: nil)
      completion(.failure(.requestError(0, error.localizedDescription)))
    }
  }
  
  override func deleteList(_ id: Int, completion: @escaping CompletionBlock<SuccessErrorModel>) {
    if let response = responseSuccessError {
      completion(.success(response))
    } else {
      let error = NSError(domain: "", code: 0, userInfo: nil)
      completion(.failure(.requestError(0, error.localizedDescription)))
    }
  }
  
  override func movieToList(_ id: Int, param: MovieToListParam, completion: @escaping CompletionBlock<SuccessErrorModel>) {
    if let response = responseSuccessError {
      completion(.success(response))
    } else {
      let error = NSError(domain: "", code: 0, userInfo: nil)
      completion(.failure(.requestError(0, error.localizedDescription)))
    }
  }
}

class ListsViewControllerMock: ListsViewInput {
  
  var isCalledFetchLists: Bool!
  var isCalledCreateNewList: Bool!
  var isCalledDeleteList: Bool!
  var isCalledMovieToList: Bool!
  var isCalledAccount: Bool!
  
  func success(items: [ListModel]) {
    isCalledFetchLists = true
  }
  
  func successCreateList(text: String) {
    isCalledCreateNewList = true
  }
  
  func successDeleteList(text: String) {
    isCalledDeleteList = true
  }
  
  func successAddMovieToList(text: String) {
    isCalledMovieToList = true
  }
  
  func failure(error: APIError) {
    isCalledFetchLists = false
    isCalledDeleteList = false
    isCalledCreateNewList = false
    isCalledMovieToList = false
    isCalledAccount = false
  }
  
  func hideIndicator() {
    
  }
  
  func showIndicator() {
    
  }
}

class ListsPresenterTest: XCTestCase {
  
  func test_getAccountSuccess() {
    let results = getResponce(file: "Account", type: AccountModel.self)
    
    let sut = makeSUT()
    sut.service.responseAccount = results.item
    
    sut.presenter.getAccount {
      
    }
    sut.service.getAccount { result in
      switch result {
      case .success(let item):
        XCTAssertNotNil(item)
      case .failure(let error):
        sut.view.failure(error: error)
      }
    }
  }
  
  func test_getAccountFailure() {
    let results = getResponce(file: "Account", type: AccountModel.self)
    
    let sut = makeSUT()
    sut.service.responseAccount = results.item
    
    sut.presenter.getAccount {
      
    }
    sut.service.getAccount { result in
      switch result {
      case .success(let item):
        XCTAssertNotNil(item)
      case .failure(let error):
        sut.view.failure(error: error)
        XCTAssertFalse(sut.view.isCalledAccount)
      }
    }
  }
  
  func test_getListsSuccess() {
    
    let results = getResponce(file: "ListModel", type: ListResponce.self)
    
    let sut = makeSUT()
    sut.service.responseList = results.item
    
    sut.presenter.getLists(state: .noRefresh)
    sut.service.getLists(1) { result in
      switch result {
      case .success(let item):
        sut.view.success(items: item.results)
        XCTAssertTrue(sut.view.isCalledFetchLists)
      case .failure(let error):
        sut.view.failure(error: error)
      }
    }
  }
  
  func test_getListsFailure() {
    
    let results = getResponce(file: "ListModel1", type: ListResponce.self)
    
    let sut = makeSUT()
    sut.service.responseList = results.item
    
    sut.presenter.getLists(state: .noRefresh)
    sut.service.getLists(1) { result in
      switch result {
      case .success(let item):
        sut.view.success(items: item.results)
        XCTAssertFalse(sut.view.isCalledFetchLists)
      case .failure(let error):
        sut.view.failure(error: error)
      }
    }
  }
  
  func test_createNewListSuccess() {
    
    let list = NewListResponce(statusMessage: "The item/record was created successfully.",
                               success: true,
                               statusCode: 1,
                               listId: 5861)
    
    let sut = makeSUT()
    sut.service.responseNewList = list
    
    sut.presenter.createList()
    let param = NewListParam(name: "List1")
    sut.presenter.param = param
    sut.presenter.createList()
    sut.service.createList(param) { result in
      switch result {
      case .success(let item):
        sut.view.successCreateList(text: item.statusMessage)
        XCTAssertTrue(sut.view.isCalledCreateNewList)
      case .failure(let error):
        sut.view.failure(error: error)
      }
    }
  }
  
  func test_createNewListFailure() {
    let sut = makeSUT()
    sut.presenter.createList()
    let param = NewListParam(name: "List1")
    sut.presenter.param = param
    sut.presenter.createList()
    sut.service.createList(param) { result in
      switch result {
      case .success(let item):
        sut.view.successCreateList(text: item.statusMessage)
        XCTAssertTrue(sut.view.isCalledCreateNewList)
      case .failure(let error):
        sut.view.failure(error: error)
        XCTAssertFalse(sut.view.isCalledCreateNewList)
      }
    }
  }
  
  func test_createMovieToListSuccess() {
    
    let responseSuccessError = SuccessErrorModel(statusCode: 12, statusMessage: "The item/record was updated successfully.")
    let sut = makeSUT()
    sut.service.responseSuccessError = responseSuccessError
    
    sut.presenter.addMovieToList(id: 1, mediaID: 1)
    
    let param = MovieToListParam(mediaID: 1)
    
    sut.service.movieToList(1, param: param) { result in
      switch result {
      case .success(let item):
        sut.view.successAddMovieToList(text: item.statusMessage)
        XCTAssertTrue(sut.view.isCalledMovieToList)
      case .failure(let error):
        sut.view.failure(error: error)
      }
    }
  }
  
  func test_createMovieToListFailure() {
    let sut = makeSUT()
    sut.presenter.addMovieToList(id: 1, mediaID: 1)
    
    let param = MovieToListParam(mediaID: 1)
    
    sut.service.movieToList(1, param: param) { result in
      switch result {
      case .success(let item):
        sut.view.successAddMovieToList(text: item.statusMessage)
        XCTAssertTrue(sut.view.isCalledMovieToList)
      case .failure(let error):
        sut.view.failure(error: error)
        XCTAssertFalse(sut.view.isCalledMovieToList)
      }
    }
  }
  
  func test_deleteListSuccess() {
    
    let responseSuccessError = SuccessErrorModel(statusCode: 12, statusMessage: "The item/record was updated successfully.")
    let sut = makeSUT()
    sut.service.responseSuccessError = responseSuccessError
    
    sut.presenter.deleteList(id: 1)
    sut.service.deleteList(1) { result in
      switch result {
      case .success(let item):
        sut.view.successDeleteList(text: item.statusMessage)
        XCTAssertTrue(sut.view.isCalledDeleteList)
      case .failure(let error):
        sut.view.failure(error: error)
      }
    }
  }
  
  func test_deleteListFailure() {
    let sut = makeSUT()
    sut.presenter.deleteList(id: 1)
    sut.service.deleteList(1) { result in
      switch result {
      case .success(let item):
        sut.view.successDeleteList(text: item.statusMessage)
        XCTAssertTrue(sut.view.isCalledDeleteList)
      case .failure(let error):
        sut.view.failure(error: error)
        XCTAssertFalse(sut.view.isCalledDeleteList)
      }
    }
  }
  
  private func makeSUT() -> (service: AccountAndListServiceSpy, presenter: ListsPresenter, view: ListsViewControllerMock) {
    let service = AccountAndListServiceSpy(client: NetworkService(session: URLSession.shared))
    let view = ListsViewControllerMock()
    let coredataStack = CoreDataStack(modelName: "Model", storageType: .inMemory)
    let persistence = MoviePersistence(context: coredataStack.managedContext, backgroundContext: coredataStack.managedContext)
    let presenter = ListsPresenter(view: view, service: service, persistence: persistence, mediaID: 1)
    return (service, presenter, view)
  }
}
