//
//  NetworkManager.swift
//  SwiftNews
//
//  Created by Mark Kim on 2020-03-21.
//  Copyright © 2020 Mark. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func execute(_ request: APIRequest, completion: @escaping (Result<Data, Error>)->()) {
        guard let url = URL(string: request.baseURL) else {
            completion(.failure(NetworkError.missing("URL")))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, responseObj, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.missing("Data")))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}



enum NetworkError: Error {
    case missing(String)
    case generic
    
    var description: String {
        switch self {
        case .missing(let text):
            return "Missing \(text)"
        case .generic:
            return "Network failed"
        }
    }
}
