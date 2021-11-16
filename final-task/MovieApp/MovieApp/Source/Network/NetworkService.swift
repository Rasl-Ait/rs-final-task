//
//  NetworkServiceProtocol.swift
//  MovieApp
//
//  Created by rasul on 10/31/21.
//

import Foundation

protocol HTTPClient {
  func request(request: URLRequest, completion: @escaping (Result<Data, APIError>) -> Void)
}

final class NetworkService: HTTPClient {
  private var session: URLSession
  
  init(session: URLSession) {
    self.session = session
  }
  
  func request(request: URLRequest, completion: @escaping (Result<Data, APIError>) -> Void) {
    debugPrint("api request \(request)")
    session.dataTask(with: request) { data, response, error in
      if let error = error as NSError? {
        if error.domain == NSURLErrorDomain && error.code == NSURLErrorCancelled {
          return
        }
        
        switch URLError.Code(rawValue: error.code) {
        case .notConnectedToInternet:
            print("NotConnectedToInternet")
        default:
          break
        }
        
        completion(.failure(.networkingError(error)))
        return
      }
      
      guard let http = response as? HTTPURLResponse, let data = data else {
        completion(.failure(.invalidResponse))
        return
      }
      
      // print(String(data: data, encoding: .utf8))
      
      switch http.statusCode {
      case 200...201:
        completion(.success(data))
      case 400...499:
        var message = ""
        var statusCode = 0
        do {
          if let json = try JSONSerialization.jsonObject(with: data, options: [])  as? [String: Any] {
            if let msgText = json["status_message"] as? String {
              message = msgText
            }
            
            if let code = json["status_code"] as? Int {
              statusCode = code
            }
          }
        } catch let error {
          completion(.failure(.jsonSerializationError(error)))
        }
        
        completion(.failure(.requestError(statusCode, message)))
      case 500...599:
        completion(.failure(.serverError))
      default:
        fatalError("Unhandled HTTP status code: \(http.statusCode)")
      }
    }
    .resume()
  }
}
