//
//  SummaryViewModel.swift
//  calhacks4
//
//  Created by Brian Hans on 10/7/17.
//  Copyright © 2017 Nick Swift. All rights reserved.
//

import Foundation

class SummaryViewModel {
    
    init(id: String) {
        self.id = id
    }
    
    func fetchItems(completion: @escaping ([Article]) -> Void) {
        Provider.request(router: .getTopic(id: id)) { (result) in
            switch result {
            case let .success(value):
                if let json = value as? [String: Any] {
                    if let articleJsons = json["articles"] as? [[String: Any]] {
                        completion(articleJsons.flatMap(Article.init))
                    }
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
    //MARK: Private variables
    
    private let id: String
}
