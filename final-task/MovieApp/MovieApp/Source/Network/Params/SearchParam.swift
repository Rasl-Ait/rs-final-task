//
//  SearchParam.swift
//  MovieApp
//
//  Created by rasul on 11/12/21.
//

import Foundation

struct SearchParam {
  let query: String
  let page: Int
  let includeAdult: Bool
  
  func getParam(param: SearchParam) -> [URLQueryItem] {

    let queries = [URLQueryItem(name: "query", value: param.query),
                 URLQueryItem(name: "page", value: param.page.toString),
                 URLQueryItem(name: "include_adult", value: param.includeAdult ? "true" : "false")]
    return queries
  }
}
