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

private func readLocalFile(forName name: String) -> Data? {
  do {
    if let bundlePath = Bundle.main.path(forResource: name,
                                         ofType: "json"),
       let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
      return jsonData
    }
  } catch {
    print(error)
  }
  
  return nil
}

func decodeJSON<T: Decodable>(type: T.Type, data: Data) -> T? {
  let decoder = JSONDecoder()
  decoder.keyDecodingStrategy = .convertFromSnakeCase
  
  do {
    let objects = try decoder.decode(type.self, from: data)
    return objects
  } catch let jsonError {
    print("Failed to decode JSON", jsonError)
    return nil
  }
}

func getResponce<T: Codable>(file: String, type: T.Type) -> (item: T?, responce: Data?) {
  guard let data = readLocalFile(forName: file) else {
    return (nil, nil)
  }
  let account = decodeJSON(type: T.self, data: data)
  let response = try! JSONEncoder().encode(account)
  return (account, response)
}
