//
//  Router.swift
//  calhacks4
//
//  Created by Nick Swift on 10/6/17.
//  Copyright © 2017 Nick Swift. All rights reserved.
//

import Foundation
import Alamofire

enum Router {

  // MARK: - Cases
  case getTopics
  case getTopic(id: String)

  // MARK: - Base URL
  var baseURL: String {
    let base = "https://calhacks4-182212.appspot.com"
    switch self {
    case .getTopics, .getTopic:
      return base
    }
  }

  // MARK: - Path
  var path: String {
    switch self {
    case .getTopics:
      return "/topic"
    case .getTopic(let id):
      return "/topic/\(id)"
    }
  }

  // MARK: - Method
  var method: HTTPMethod {
    switch self {
    case .getTopics, .getTopic:
      return .get
    }
  }

  // MARK: - Parameters
  var parameters: [String: Any]? {
    switch self {
    case .getTopics, .getTopic:
      return nil
    }
  }

  // MARK: - Encoding
  var encoding: ParameterEncoding {
    return JSONEncoding.default
  }

  // MARK: - Headers
  var headers: [String: String]? {
    return nil
  }

}
