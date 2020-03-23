//
//  NewsListService.swift
//  SwiftNews
//
//  Created by Mark Kim on 2020-03-22.
//  Copyright © 2020 Mark. All rights reserved.
//

import UIKit

class NewsListService {
    var newsArticles: [NewsArticle] = []
}

// MARK: - datasource
extension NewsListService {
    var numberOfArticles: Int {
        return newsArticles.count
    }
    
    func article(atIndexPath indexPath: IndexPath) -> NewsArticle {
        return newsArticles[indexPath.row]
    }
}

// MARK: - fetch news articles
extension NewsListService {
    func fetchArticles(completion: @escaping (Error?) -> ()) {
        let request = GETSwiftNews()
        NetworkManager.shared.execute(request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let response = try? JSONDecoder().decode(Response.self, from: data) else {
                    completion(ParseError.generic)
                    return
                }
                
                self.newsArticles = response.newsArticles
                completion(nil)
                return
            
            case .failure(let error):
                completion(error)
                return
            }
        }
    }
}

extension NewsListService {
    func getImage() {
        
    }
}
