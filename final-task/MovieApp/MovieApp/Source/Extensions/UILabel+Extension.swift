//
//  UILabel.swift
//  123
//
//  Created by rasul on 2/23/21.
//

import UIKit

extension UILabel {
	convenience init(_ title: String, alignment: NSTextAlignment, color: UIColor?, fontName: UIFont?) {
		self.init()
		text = title
		font = fontName
		textAlignment = alignment
		textColor = color
		// minimumScaleFactor = 0.8
		sizeToFit()
		// adjustsFontSizeToFitWidth = true
		lineBreakMode = .byTruncatingTail
	}
  
  func setMutString(_ entireText: String, text: String, font: UIFont, textColor: UIColor) {
    let mutableString = NSMutableAttributedString(string: entireText)
    mutableString.setColorForText(textToFind: text, font: font, withColor: textColor)
    attributedText = mutableString
  }
}
