//
//  Log.swift
//  MovieApp
//
//  Created by rasul on 12/1/21.
//

import Foundation
import CocoaLumberjackSwift

class Log {
  static func logInfo(text: String) {
    DDLogInfo(text)
  }
}
