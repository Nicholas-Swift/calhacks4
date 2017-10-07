//
//  Router.swift
//  calhacks4
//
//  Created by Nick Swift on 10/6/17.
//  Copyright © 2017 Nick Swift. All rights reserved.
//

import Foundation

enum Router {
  
  // MARK: - Cases
  case test
  
  // MARK: - Base URL
  var baseURL: String {
    switch self {
    case test:
      return "https:fewjiofw"
    }
  }
  
  // MARK: - Path
  var path: String {
    switch self {
    case test:
      return "/path"
    }
  }
  
  // MARK: - Method
  var method: Method {
    switch self {
    case test:
      return .get
    }
  }
  
  // MARK: - 
  
}
