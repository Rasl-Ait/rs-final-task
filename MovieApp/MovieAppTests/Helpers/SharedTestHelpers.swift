
import Foundation

import XCTest
@testable import MovieApp

class SharedTestHelpers: XCTestCase {

func anyNSError() -> NSError {
  return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
  return URL(string: "http://any-url.com")!
}

  static private func readLocalFile(forName name: String) -> Data? {
  do {
    guard let urlPath = Bundle(for: SharedTestHelpers.self).url(forResource: name, withExtension: "json") else {
      return nil
    }
       let data = try Data(contentsOf: urlPath)
      return data
  } catch {
    print(error)
  }
  
  return nil
}

 static private func decodeJSON<T: Decodable>(type: T.Type, data: Data) -> T? {
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

static func getResponce<T: Codable>(file: String, type: T.Type) -> (item: T?, responce: Data?) {
  guard let data = readLocalFile(forName: file) else {
    return (nil, nil)
  }
  let account = decodeJSON(type: T.self, data: data)
  let response = try! JSONEncoder().encode(account)
  return (account, response)
}
}
