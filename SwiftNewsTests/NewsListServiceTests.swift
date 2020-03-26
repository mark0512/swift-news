//
//  NewsListServiceTests.swift
//  SwiftNewsTests
//
//  Created by Mark Kim on 2020-03-26.
//  Copyright © 2020 Mark. All rights reserved.
//

import XCTest
@testable import SwiftNews

/**
 Unit test for NewListService
 */
class NewsListServiceTests: XCTestCase {
    
    var newsListService = NewsListService()
    
    func testNumberOfArticlesWithEmptyArticle() {
        XCTAssertEqual(newsListService.numberOfArticles, 0, "number of articles should be 0.")
    }
    
    func testNumberOfArticlesWithArticles() {
        createData()
        XCTAssertEqual(newsListService.numberOfArticles, 2, "number of articles should be 0.")
    }
    
    func testArticle() {
        createData()
        let firstIndex = IndexPath(row: 0, section: 0)
        let firstNewsArticle = newsListService.article(atIndexPath: firstIndex)
        XCTAssertEqual(firstNewsArticle.title, "first", "title should be first")
        XCTAssertEqual(firstNewsArticle.thumbnail, "firstThumbnail", "thunbnail should be firstThumbnail")
        XCTAssertEqual(firstNewsArticle.desc, "firstDescription", "description should be firstDescription")

        let secondIndex = IndexPath(row: 1, section: 0)
        let secondNewsArticle = newsListService.article(atIndexPath: secondIndex)
        XCTAssertEqual(secondNewsArticle.title, "second", "title should be second")
        XCTAssertEqual(secondNewsArticle.thumbnail, "secondThumbnail", "thumbnail should be secondThumbnail")
        XCTAssertEqual(secondNewsArticle.desc, "secondDescription", "description should be secondDescription")
    }
}

extension NewsListServiceTests {
    func createData() {
        let firstArticle = NewsArticle.init(title: "first", thumbnail: "firstThumbnail", desc: "firstDescription")
        let secondArticle = NewsArticle.init(title: "second", thumbnail: "secondThumbnail", desc: "secondDescription")

        newsListService.newsArticles.append(firstArticle)
        newsListService.newsArticles.append(secondArticle)
    }
}
