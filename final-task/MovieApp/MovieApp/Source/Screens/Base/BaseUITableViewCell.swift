
import UIKit

class BaseUITableViewCell: UITableViewCell {
	
	// MARK: - Lifecycle
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.selectionStyle = .none
		self.addSubViews()
	}
	
	func addSubViews() {
		fatalError("Should override " + #function + " in " + String(describing: type(of: self)))
	}
}
