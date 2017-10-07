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
  
  static func request(router: Router) {
    let url = router.baseURL + router.path
    Alamofire.request(url, method: router.method, parameters: router.parameters, encoding: router.encoding, headers: router.headers).responseJSON { response in
      print("Request: \(String(describing: response.request))")   // original url request
      print("Response: \(String(describing: response.response))") // http url response
      print("Result: \(response.result)")                         // response serialization result
      
      if let json = response.result.value {
        print("JSON: \(json)") // serialized json response
      }
      
      if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
        print("Data: \(utf8Text)") // original server data as UTF8 string
      }
    }
  }
  
}
