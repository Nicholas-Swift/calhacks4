//
//  Provider.swift
//  calhacks4
//
//  Created by Nick Swift on 10/6/17.
//  Copyright © 2017 Nick Swift. All rights reserved.
//

import Foundation
import Alamofire

class Provider {
    
    static func request(router: Router, completion: @escaping (Result<Any>) -> Void) {
        let url = router.baseURL + router.path
        Alamofire.request(url, method: router.method).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            switch response.result {
            case let .success(value):
                return completion(Result.success(value))// serialized json response
            case let .failure(error):
                return completion(Result.failure(error))
            }
            
            
        }
    }
    
}
