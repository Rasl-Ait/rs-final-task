//
//  UIButton.swift
//  123
//
//  Created by rasul on 2/23/21.
//

import UIKit

extension UIButton {	
	convenience init(_ title: String, titleColor: UIColor, font: UIFont?) {
		self.init()
    disableAutoresizingMask()
		setTitle(title, for: .normal)
		setTitleColor(titleColor, for: .normal)
		titleLabel?.font = font
	}
}
