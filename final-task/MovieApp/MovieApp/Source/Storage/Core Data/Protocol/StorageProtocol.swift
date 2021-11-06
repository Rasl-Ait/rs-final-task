
import Foundation

protocol StorageProtocol: AnyObject {
  var items: [ListModel] { get }
  
  func add(_ item: ListModel)
  func fetchItem(_ predicateType: PredicateType) -> ListModel?
  func remove(with id: Int)
  func fetch(_ predicate: NSPredicate?)
}
