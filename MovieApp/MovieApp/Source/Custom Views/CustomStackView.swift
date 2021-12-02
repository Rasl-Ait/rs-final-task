
import UIKit

final class CustomStackView: UIStackView {
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	init(axis: NSLayoutConstraint.Axis, spacing: CGFloat, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill) {
		super.init(frame: .zero)
		self.spacing = spacing
		self.axis = axis
	}
	
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
