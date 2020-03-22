//
//  ImageDownloader.swift
//  SwiftNews
//
//  Created by Mark Kim on 2020-03-22.
//  Copyright © 2020 Mark. All rights reserved.
//

import UIKit

extension UIImageView {
    static let imageCache = NSCache<NSString, UIImage>()

    func getImage(url: String) {
        if let image = UIImageView.imageCache.object(forKey: url as NSString) {
            DispatchQueue.main.async {
                self.image = image
            }
        } else {
            downloadImage(url) { image in
                if let image = image {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
    
    private func downloadImage(_ imageURL: String, completion: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: imageURL) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                UIImageView.imageCache.setObject(image, forKey: (imageURL as NSString))
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
}
