//
//  Article.swift
//  SwiftNews
//
//  Created by Mark Kim on 2020-03-22.
//  Copyright © 2020 Mark. All rights reserved.
//

import Foundation

struct ArticleLists: Decodable {
    let data: TopData
    
    struct TopData: Decodable {
        let articles: [Children]

        enum CodingKeys: String, CodingKey {
            case articles = "children"
        }
        struct Children: Decodable {
            let article: NewsArticle
            
            enum CodingKeys: String, CodingKey {
                case article = "data"
            }
        }
    }
    
    var newsArticles: [NewsArticle] {
        return data.articles.map { $0.article }
    }
}

struct NewsArticle: Decodable {
    let title: String?
    let thumbnail: String?
    let desc: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case desc = "selftext"
        case thumbnail = "thumbnail"
    }
    
    var hasThumbnail: Bool {
        return thumbnail?.hasPrefix("https://") ?? false
    }
}
