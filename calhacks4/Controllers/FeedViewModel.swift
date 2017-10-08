//
//  FeedViewModel.swift
//  calhacks4
//
//  Created by Brian Hans on 10/7/17.
//  Copyright © 2017 Nick Swift. All rights reserved.
//

import Foundation

class FeedViewModel {
    
    
    public var sectionCount: Int {
        return 1
    }
    
    public var rowCount: Int {
        return topics.count
    }
    
    public func fetchTopics(completion: @escaping ([Topic]) -> Void) {
        
        Provider.request(router: .getTopics) { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case let .success(value):
                if let json = value as? [[String: Any]] {
                    self.topics = json.flatMap(Topic.init)
                    completion(self.topics)
                }
            case let .failure(error):
                print(error)
            }
        }
        
    }
    
    func item(for indexPath: IndexPath) -> Topic {
        return topics[indexPath.row]
    }
    
    // MARK: Private variables
    
    private var topics: [Topic] = []

}
