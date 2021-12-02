//
//  Global.swift
//  Wallets
//
//  Created by rasul on 9/25/21.
//

import Foundation

struct Constant {
  static let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhMTAxYzdlMWM2YTNmOTQyY2ZjMjViOTViZTkzNjMwNiIsInN1YiI6IjViNGM3ODc5OTI1MTQxN2QyNzAzODc3NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IhUDUTVUnFZbGylMDnj8tWF6a30ATmLxp4aN9SVtXko"
}

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
