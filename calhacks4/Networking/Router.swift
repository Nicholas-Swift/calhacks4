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
    case getArticles
    
    // MARK: - Base URL
    var baseURL: String {
        switch self {
        case .getArticles:
            return "https://calhacks4-182212.appspot.com"
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .getArticles:
            return "/articles"
        }
    }
    
    // MARK: - Method
    var method: HTTPMethod {
        switch self {
        case .getArticles:
            return .get
        }
    }
    
    // MARK: - Parameters
    var parameters: [String: Any] {
        return [:]
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
