
import UIKit

extension NSMutableAttributedString {

  func setColorForText(textToFind: String, font: UIFont, withColor color: UIColor) {
		let range: NSRange = self.mutableString.range(of: textToFind, options: .caseInsensitive)
		self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    self.addAttribute(NSAttributedString.Key .font, value: font, range: range)
	}	
}
