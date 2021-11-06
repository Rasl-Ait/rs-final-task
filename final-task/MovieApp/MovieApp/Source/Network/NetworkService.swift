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

   init(session: URLSession = .shared) {
    let config = URLSessionConfiguration.default
    config.requestCachePolicy = .reloadIgnoringLocalCacheData
    config.urlCache = nil
    config.httpAdditionalHeaders = ["Content-Type": "application/json",
                                    "Accept": "application/json",
                                    "Authorization": "Bearer \(Constant.token)"]
    self.session = URLSession(configuration: config)
  }
  
  func request(request: URLRequest, completion: @escaping (Result<Data, APIError>) -> Void) {
    debugPrint("api request \(request)")
    session.dataTask(with: request) { data, response, error in
      if let error = error as NSError? {
        if error.domain == NSURLErrorDomain && error.code == NSURLErrorCancelled {
          return
        }

        completion(.failure(.networkingError(error)))
        return
      }
      
      guard let http = response as? HTTPURLResponse, let data = data else {
        completion(.failure(.invalidResponse))
        return
      }
      
      switch http.statusCode {
      case 200...201:
          completion(.success(data))
      case 400...499:
        var message = ""
        var statusCode = 0
        if let json = try! JSONSerialization.jsonObject(with: data, options: [])  as? [String: Any] {
          if let msgText = json["status_message"] as? String {
            message = msgText
          }
          
          if let code = json["status_code"] as? Int {
            statusCode = code
          }
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
