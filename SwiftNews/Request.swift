//
//  Request.swift
//  SwiftNews
//
//  Created by Mark Kim on 2020-03-21.
//  Copyright © 2020 Mark. All rights reserved.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
    case post = "POST" //not using at the moment
}

protocol APIRequest {
    var baseURL: String { get }
    var requestMethod: RequestMethod { get }
}

extension APIRequest {
    var parameters: [String: Any] {
        return [:]
    }
    
    var requestMethod: RequestMethod {
        return .get
    }
}

struct GETSwiftNews: APIRequest {
    var baseURL = "https://www.reddit.com/r/swift/.json"
}
