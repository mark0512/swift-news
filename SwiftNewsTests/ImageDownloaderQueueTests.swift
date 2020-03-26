//
//  ImageDownloaderQueueTests.swift
//  SwiftNewsTests
//
//  Created by Mark Kim on 2020-03-25.
//  Copyright © 2020 Mark. All rights reserved.
//

import XCTest
@testable import SwiftNews

class ImageDownloaderQueueTests: XCTestCase {
    override func setUp() {
        super.setUp()
        ImageDownloaderQueue.shared.reset()
    }
    
    func testDidAddQueueForEmptyQueue() {
        XCTAssertTrue(ImageDownloaderQueue.shared.didAddQueue("a"), "URL \"a\" must be added to empty queue")
    }
    
    func testDidAddQueueForSameURL() {
        XCTAssertTrue(ImageDownloaderQueue.shared.didAddQueue("a"), "URL \"a\" sting should be added to empty queue")
        XCTAssertTrue(!ImageDownloaderQueue.shared.didAddQueue("a"), "URL \"a\" sting should not be added to empty queue")
    }
    
    func testRemoveQueueWithEmptyQueue() {
        XCTAssertEqual(ImageDownloaderQueue.shared.downloadQueue.count, 0, "Number of queue should be 0")
        ImageDownloaderQueue.shared.removeQueue("a")
        XCTAssertEqual(ImageDownloaderQueue.shared.downloadQueue.count, 0, "Number of queue should be 0")
    }
    
    func testRemoveQueueWithExistingURL() {
        ImageDownloaderQueue.shared.didAddQueue("a")
        XCTAssertEqual(ImageDownloaderQueue.shared.downloadQueue.count, 1, "Number of queue should be 0")
        ImageDownloaderQueue.shared.removeQueue("a")
        XCTAssertEqual(ImageDownloaderQueue.shared.downloadQueue.count, 0, "Number of queue should be 0")
    }
    
    func testRemoveQueueWithNonExistingURL() {
        ImageDownloaderQueue.shared.didAddQueue("a")
        XCTAssertEqual(ImageDownloaderQueue.shared.downloadQueue.count, 1, "Number of queue should be 0")
        ImageDownloaderQueue.shared.removeQueue("b")
        XCTAssertEqual(ImageDownloaderQueue.shared.downloadQueue.first, "a", "URL shouldn't be removed")
    }
}
