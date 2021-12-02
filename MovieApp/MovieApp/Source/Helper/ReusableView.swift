
import UIKit

protocol ReusableView: AnyObject {
	static var nib: UINib { get }
}

extension ReusableView {
	static var nib: UINib {
		return UINib(nibName: name, bundle: Bundle(for: self))
	}
	
	static var name: String {
		return String(describing: self)
	}
}

extension ReusableView where Self: UIView {
	static func loadFromNib() -> Self {
		guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else { fatalError("error") }
		
		return view
	}
}

extension UITableViewCell: ReusableView { }
extension UITableViewHeaderFooterView: ReusableView { }
extension UICollectionReusableView: ReusableView { }
