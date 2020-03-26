//
//  NewsError.swift
//  SwiftNews
//
//  Created by Mark Kim on 2020-03-22.
//  Copyright © 2020 Mark. All rights reserved.
//

import Foundation

enum NetworkError: LocalizedError {
    case missing(String)
    case generic
    
    var errorDescription: String? {
        switch self {
        case .missing(let text):
            return "Missing \(text)"
        case .generic:
            return "Network failed"
        }
    }
}

enum ParseError: String, LocalizedError {
    case generic
    
    var errorDescription: String? {
        switch self {
        default:
            return "Unable to parse"
        }
    }
}
