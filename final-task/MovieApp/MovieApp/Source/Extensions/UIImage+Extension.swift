//
//  UIImage.swift
//  GameCounter
//
//  Created by rasul on 8/28/21.
//

import UIKit

extension UIImage {
    func withColor(_ color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        guard let ctx = UIGraphicsGetCurrentContext(), let cgImage = cgImage else { return self }
        color.setFill()
        ctx.translateBy(x: 0, y: size.height)
        ctx.scaleBy(x: 1.0, y: -1.0)
        ctx.clip(to: CGRect(x: 0, y: 0, width: size.width, height: size.height), mask: cgImage)
        ctx.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        guard let colored = UIGraphicsGetImageFromCurrentImageContext() else { return self }
        UIGraphicsEndImageContext()
        return colored
    }
  
  static func setImage(_ type: IconType) -> UIImage {
    UIImage(named: type.rawValue) ?? UIImage()
  }
  
  static func setImage(_ type: SFSymbolConstants) -> UIImage {
    UIImage(systemName: type.rawValue) ?? UIImage()
  }
  
  func toString() -> String? {
    let data: Data? = self.pngData()
       return data?.base64EncodedString(options: .endLineWithLineFeed)
   }
}
