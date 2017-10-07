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
        return articles.count
    }
    
    public func fetchArticles(completion: ([Article]) -> Void) {
        let article = Article()
        
        self.articles = [article, article,article, article,article, article,article, article]
        completion([article, article,article, article,article, article,article, article])
    }
    
    func item(for indexPath: IndexPath) -> Article {
        return articles[indexPath.row]
    }
    
    // MARK: Private variables
    
    private var articles: [Article] = []

}
