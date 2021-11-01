//
//  XCTestsCase+MemoryLeakTracking.swift
//  EssentialFeedTests
//
//  Created by Alex Tapia on 06/01/21.
//

import XCTest

extension XCTestCase {
  
  func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
    addTeardownBlock { [weak instance] in // We need to capture as weak to have a NOT strong reference.
      XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
    }
  }
}
