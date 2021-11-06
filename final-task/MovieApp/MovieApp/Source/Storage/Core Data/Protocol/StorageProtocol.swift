
import Foundation

protocol StorageProtocol: AnyObject {
  var items: [ListModel] { get }
  
  func add(_ item: ListModel)
  func remove(with uid: String)
  func fetch(_ predicate: NSPredicate?)
}
