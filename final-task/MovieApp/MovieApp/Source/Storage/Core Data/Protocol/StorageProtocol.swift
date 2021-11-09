
import Foundation

protocol StorageProtocol: AnyObject {
  var items: [ListModel] { get }
  
  func addList(_ item: ListModel)
  func addMovie(_ item: MovieModel, listID: Int)
  func fetchItem(_ predicateType: PredicateType) -> ListModel?
  func fetchMovie(_ predicateType: PredicateType) -> MovieModel?
  func remove(with id: Int)
  func removeMovie(with id: Int)
  func fetch(_ predicate: NSPredicate?)
}
