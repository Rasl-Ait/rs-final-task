
import UIKit

extension UITableView {
	func register<T: UITableViewCell>(_ :T.Type) {
		register(T.self, forCellReuseIdentifier: T.name)
	}
	
	func register<T: UITableViewHeaderFooterView>(_ :T.Type) {
		register(T.self, forHeaderFooterViewReuseIdentifier: T.name)
	}
	
	func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
		guard let cell = dequeueReusableCell(withIdentifier: T.name, for: indexPath) as? T else {
			fatalError("Could not deque cell with identifier")
		}
		return cell
	}
	
	func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
		guard let header = dequeueReusableHeaderFooterView(withIdentifier: T.name) as? T else {
			fatalError("Could not deque cell with identifier")
		}
		return header
	}
}
