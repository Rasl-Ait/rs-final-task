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
  private var presenter: ListsPresenter!
  private var view: ListsViewControllerMock!
  private var service: AccountAndListServiceSpy!
  var coredataStack: CoreDataStack!
  var persistence: StorageProtocol!

  override func setUp() {
    super.setUp()
    coredataStack = CoreDataStack(modelName: "Model", storageType: .inMemory)
    persistence = MoviePersistence(context: coredataStack.managedContext, backgroundContext: coredataStack.managedContext)
  }
  
  override func tearDown() {
    presenter = nil
    persistence = nil
    service = nil
    coredataStack = nil
    view = nil
    super.tearDown()
  }
  
  func test_getAccountSuccess() {
    
    let results = getResponce(file: "Account", type: AccountModel.self)
    
    service = AccountAndListServiceSpy(client: NetworkService(session: URLSession.shared))
    service.responseAccount = results.item
    
    view = ListsViewControllerMock()
    presenter = ListsPresenter(view: view, service: service, persistence: persistence, mediaID: 1)
    self.presenter.getAccount {
      
    }
    service.getAccount { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        XCTAssertNotNil(item)
      case .failure(let error):
        self.view.failure(error: error)
      }
    }
  }
  
  func test_getAccountFailure() {
    service = AccountAndListServiceSpy(client: NetworkService(session: URLSession.shared))
    
    view = ListsViewControllerMock()
    presenter = ListsPresenter(view: view, service: service, persistence: persistence, mediaID: 1)
    self.presenter.getAccount {
      
    }
    service.getAccount { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        XCTAssertNotNil(item)
      case .failure(let error):
        self.view.failure(error: error)
        XCTAssertFalse(self.view.isCalledAccount)
      }
    }
  }

  func test_getListsSuccess() {
    
    let results = getResponce(file: "ListModel", type: ListResponce.self)
    
    service = AccountAndListServiceSpy(client: NetworkService(session: URLSession.shared))
    service.responseList = results.item
    
    view = ListsViewControllerMock()
    presenter = ListsPresenter(view: view, service: service, persistence: persistence, mediaID: 1)
    self.presenter.getLists(state: .noRefresh)
    service.getLists(1) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        self.view.success(items: item.results)
        XCTAssertTrue(self.view.isCalledFetchLists)
      case .failure(let error):
        self.view.failure(error: error)
      }
    }
  }
  
func test_getListsFailure() {
  
  let results = getResponce(file: "ListModel1", type: ListResponce.self)
  
  service = AccountAndListServiceSpy(client: NetworkService(session: URLSession.shared))
  service.responseList = results.item
  
  view = ListsViewControllerMock()
  presenter = ListsPresenter(view: view, service: service, persistence: persistence, mediaID: 1)
  self.presenter.getLists(state: .noRefresh)
  service.getLists(1) { [weak self] result in
    guard let self = self else { return }
    switch result {
    case .success(let item):
      self.view.success(items: item.results)
    case .failure(let error):
      self.view.failure(error: error)
    }
  }
  
  XCTAssertFalse(view.isCalledFetchLists)
}
  
  func test_createNewListSuccess() {
    
    let list = NewListResponce(statusMessage: "The item/record was created successfully.",
                               success: true,
                               statusCode: 1,
                               listId: 5861)
    
    service = AccountAndListServiceSpy(client: NetworkService(session: URLSession.shared))
    service.responseNewList = list
    
    view = ListsViewControllerMock()
    presenter = ListsPresenter(view: view, service: service, persistence: persistence, mediaID: 1)
    presenter.createList()
    let param = NewListParam(name: "List1")
    presenter.param = param
    presenter.createList()
    service.createList(param) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        self.view.successCreateList(text: item.statusMessage)
        XCTAssertTrue(self.view.isCalledCreateNewList)
      case .failure(let error):
        self.view.failure(error: error)
      }
    }
  }
  
  func test_createNewListFailure() {
    service = AccountAndListServiceSpy(client: NetworkService(session: URLSession.shared))
    
    view = ListsViewControllerMock()
    presenter = ListsPresenter(view: view, service: service, persistence: persistence, mediaID: 1)
    presenter.createList()
    let param = NewListParam(name: "List1")
    presenter.param = param
    presenter.createList()
    service.createList(param) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        self.view.successCreateList(text: item.statusMessage)
        XCTAssertTrue(self.view.isCalledCreateNewList)
      case .failure(let error):
        self.view.failure(error: error)
        XCTAssertFalse(self.view.isCalledCreateNewList)
      }
    }
  }
  
  func test_createMovieToListSuccess() {
    
    let responseSuccessError = SuccessErrorModel(statusCode: 12, statusMessage: "The item/record was updated successfully.")
    
    service = AccountAndListServiceSpy(client: NetworkService(session: URLSession.shared))
    service.responseSuccessError = responseSuccessError
    
    view = ListsViewControllerMock()
    presenter = ListsPresenter(view: view, service: service, persistence: persistence, mediaID: 1)
    presenter.addMovieToList(id: 1, mediaID: 1)
    
    let param = MovieToListParam(mediaID: 1)
    
    service.movieToList(1, param: param) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        self.view.successAddMovieToList(text: item.statusMessage)
        XCTAssertTrue(self.view.isCalledMovieToList)
      case .failure(let error):
        self.view.failure(error: error)
      }
    }
  }
  
  func test_createMovieToListFailure() {
    service = AccountAndListServiceSpy(client: NetworkService(session: URLSession.shared))
    
    view = ListsViewControllerMock()
    presenter = ListsPresenter(view: view, service: service, persistence: persistence, mediaID: 1)
    presenter.addMovieToList(id: 1, mediaID: 1)
    
    let param = MovieToListParam(mediaID: 1)
    
    service.movieToList(1, param: param) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        self.view.successAddMovieToList(text: item.statusMessage)
        XCTAssertTrue(self.view.isCalledMovieToList)
      case .failure(let error):
        self.view.failure(error: error)
        XCTAssertFalse(self.view.isCalledMovieToList)
      }
    }
  }

  func test_deleteListSuccess() {
    
    let responseSuccessError = SuccessErrorModel(statusCode: 12, statusMessage: "The item/record was updated successfully.")
    
    service = AccountAndListServiceSpy(client: NetworkService(session: URLSession.shared))
    service.responseSuccessError = responseSuccessError
    
    view = ListsViewControllerMock()
    presenter = ListsPresenter(view: view, service: service, persistence: persistence, mediaID: 1)
    presenter.deleteList(id: 1)
    service.deleteList(1) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        self.view.successDeleteList(text: item.statusMessage)
        XCTAssertTrue(self.view.isCalledDeleteList)
      case .failure(let error):
        self.view.failure(error: error)
      }
    }
  }
  
  func test_deleteListFailure() {
    service = AccountAndListServiceSpy(client: NetworkService(session: URLSession.shared))
    
    view = ListsViewControllerMock()
    presenter = ListsPresenter(view: view, service: service, persistence: persistence, mediaID: 1)
    presenter.deleteList(id: 1)
    service.deleteList(1) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let item):
        self.view.successDeleteList(text: item.statusMessage)
        XCTAssertTrue(self.view.isCalledDeleteList)
      case .failure(let error):
        self.view.failure(error: error)
        XCTAssertFalse(self.view.isCalledDeleteList)
      }
    }
  }
  
private func makeSUT() -> (service: AccountAndListService, client: MockHTTPClient) {
  let httpClient = MockHTTPClient()
  let sut = AccountAndListService(client: httpClient)
  return (sut, httpClient)
}
}

//
//class ListsViewControllerMock: ListsViewInput {
//
//  var lists: [ListModel] = []
//  var successCreateList = ""
//  var successDeleteList = ""
//
//  func success(items: [ListModel]) {
//    lists = items
//  }
//
//  func successCreateList(text: String) {
//    successCreateList = text
//  }
//
//  func successDeleteList(text: String) {
//    successDeleteList = text
//  }
//
//  func successAddMovieToList(text: String) {
//
//  }
//
//  func failure(error: APIError) {
//
//  }
//
//  func hideIndicator() {
//
//  }
//
//  func showIndicator() {
//
//  }
//}
//
//class ListSPresenterSpy: ListsViewOutput {
//
//  weak var view: ListsViewInput?
//
//  init(view: ListsViewInput) {
//    self.view = view
//  }
//
//  var lists: [ListModel] = []
//
//  func getLists(state: StateLoad) {
//    let item = ListModel(description: "",
//                         favoriteCount: 1,
//                         id: 1,
//                         itemCount: 1,
//                         listType: "movie",
//                         name: "List 1",
//                         posterPath: nil,
//                         movies: nil)
//    lists.append(item)
//    view?.success(items: lists)
//  }
//
//  func createList() {
//    view?.successCreateList(text: "Create list success")
//
//  }
//
//  func deleteList(id: Int) {
//    view?.successDeleteList(text: "Delete list success")
//  }
//
//  func didSelectRowAt(list: ListModel) {
//
//  }
//
//  func addText(name: String) {
//
//  }
//
//  func pop() {
//
//  }
//}
//
//class ListsPresenterTest: XCTestCase {
//  private var presenter: ListSPresenterSpy!
//  private var view: ListsViewControllerMock!
//
//  override func setUp() {
//    super.setUp()
//   view = ListsViewControllerMock()
//    presenter = ListSPresenterSpy(view: view)
//  }
//
//  override func tearDown() {
//    presenter = nil
//    view = nil
//    super.tearDown()
//  }
//
//  func test_getListsSuccess() {
//    presenter.getLists(state: .noRefresh)
//    XCTAssertEqual(view.lists.count, 1)
//}
//
//  func test_createListSuccess() {
//    presenter.createList()
//    XCTAssertEqual(view.successCreateList, "Create list success")
//}
//
//  func test_deteleListSuccess() {
//    presenter.deleteList(id: 1)
//    XCTAssertEqual(view.successDeleteList, "Delete list success")
//}
//}
