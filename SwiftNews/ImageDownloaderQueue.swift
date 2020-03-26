//
//  ImageDownloaderQueue.swift
//  SwiftNews
//
//  Created by Mark Kim on 2020-03-22.
//  Copyright © 2020 Mark. All rights reserved.
//

import Foundation

class ImageDownloaderQueue {
    static let shared = ImageDownloaderQueue()
    private(set) var downloadQueue = Set<String>()
    
    /**
     Add url string to download queue
     - Returns: Boolean if success insert into queue
     */
    @discardableResult func didAddQueue(_ urlString: String) -> Bool {
        if !isExisted(urlString) {
            downloadQueue.insert(urlString)
            return true
        }
        
        return false
    }
    
    /**
     Remove url from the queue
     */
    func removeQueue(_ urlSting: String) {
        downloadQueue.remove(urlSting)
    }
    
    /**
     Check if url is existed in download queue
     - Returns: Boolean if url is exited in queue
     */
    func isExisted(_ urlString: String) -> Bool {
        return downloadQueue.contains(urlString)
    }
    
    func reset() {
        downloadQueue.removeAll()
    }
}
