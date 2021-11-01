//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Alex Tapia on 29/08/21.
//

import Foundation

func anyNSError() -> NSError {
  return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
  return URL(string: "http://any-url.com")!
}
