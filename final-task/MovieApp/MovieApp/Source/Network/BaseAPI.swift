//
//  BaseAPI.swift
//  MovieApp
//
//  Created by rasul on 10/31/21.
//

import Foundation

class BaseAPI<U: TargetType> {
  private let client: HTTPClient
  
  init(client: HTTPClient) {
    self.client = client
  }
  
  func getData<T: Decodable>(target: U, completion: @escaping CompletionBlock<T>) {
    let httpMethod = HTTPMethod(rawValue: target.method.rawValue)
    let param = buildParams(task: target.task)
    let request: URLRequest = .queryParams(target.path, param: param, httpMethod: httpMethod)
    client.request(request: request, completion: parseDecodable(completion: completion))
  }
}

extension URLRequest {
  static func queryParams(_ path: String, param: ([URLQueryItem], Encodable?), httpMethod: HTTPMethod? = .get) -> URLRequest {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.themoviedb.org"
    components.path = "/3/\(path)"
    if !param.0.isEmpty {
      components.queryItems = param.0
    }
   
    var request = URLRequest(url: components.url!)
    request.httpMethod = httpMethod?.rawValue
    
    if param.1 != nil {
      request.httpBody = try! param.1?.jsonData()
    }
    
    return request
  }
}

extension BaseAPI {
  private func buildParams(task: Task) -> ([URLQueryItem], Encodable?) {
    switch task {
    case .requestPlain:
      return ([], nil)
    case .urlQueryParameters(parameters: let items):
      return (items, nil)
    case .requestPostParameters(parameters: let param):
      return ([], param)
    case .postAndGetParameters(parameters: let param, query: let query):
    return (query, param)
    }
  }
  
  private func parseDecodable<T: Decodable>(completion: @escaping CompletionBlock<T>) -> CompletionDataBlock {
    return { result in
      switch result {
      case .success(let data):
        guard let object = self.decodeJSON(type: T.self, data: data) else {
          return
        }
          completion(.success(object))
      
      case .failure(let error):
          completion(.failure(error))
      }
    }
  }
  
  func decodeJSON<T: Decodable>(type: T.Type, data: Data) -> T? {
    let decoder = JSONDecoder()
    
    do {
      let objects = try decoder.decode(type.self, from: data)
      return objects
    } catch let jsonError {
      print("Failed to decode JSON", jsonError)
      return nil
    }
  }
}
