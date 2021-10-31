//
//  Global.swift
//  Wallets
//
//  Created by rasul on 9/25/21.
//

import Foundation

func mainQueue(_ completion: @escaping VoidClosure) {
  DispatchQueue.main.async {
    completion()
  }
}

func globalQueue(_ completion: @escaping VoidClosure) {
  DispatchQueue.global().async {
    completion()
  } 
}

func mainQueue(after: TimeInterval, _ work: @escaping VoidClosure) {
    DispatchQueue.main.asyncAfter(deadline: .now() + after, execute: work)
}
