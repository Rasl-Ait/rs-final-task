
import Foundation

protocol StorageProtocol: AnyObject {
  var items: [ListModel] { get }
  
  func addList(_ item: ListModel)
  func addMovie(_ item: MovieModel, list: ListEntity)
  func fetchItem(_ predicateType: PredicateType) -> ListModel?
  func remove(with id: Int)
  func fetch(_ predicate: NSPredicate?)
}
