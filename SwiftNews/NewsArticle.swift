//
//  Article.swift
//  SwiftNews
//
//  Created by Mark Kim on 2020-03-22.
//  Copyright © 2020 Mark. All rights reserved.
//

import Foundation

struct Response: Decodable {
    let data: TopData
    
    var newsArticles: [NewsArticle] {
        var articles: [NewsArticle] = []
        for child in data.articles {
            articles.append(child.article)
        }
        return articles
    }
}

struct TopData: Decodable {
    let articles: [Children]
    
    enum CodingKeys: String, CodingKey {
        case articles = "children"
    }
}

struct Children: Decodable {
    let article: NewsArticle
    
    enum CodingKeys: String, CodingKey {
        case article = "data"
    }
}

struct NewsArticle: Decodable {
    let title: String
    let thumbnail: String
    let desc: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case desc = "selftext"
        case thumbnail = "thumbnail"
    }
    
    var hasThumbnail: Bool {
        return thumbnail.hasPrefix("https://")
    }
}
