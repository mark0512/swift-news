//
//  UIImageView+Extension.swift
//  SwiftNews
//
//  Created by Mark Kim on 2020-03-25.
//  Copyright © 2020 Mark. All rights reserved.
//

import UIKit

extension UIImageView {
    static let imageCache = NSCache<NSString, UIImage>()

    func getImage(urlString: String?, completion: (() -> ())? = nil) {
        guard let urlString = urlString else {
            return
        }
        self.image = nil
        
        if let image = UIImageView.imageCache.object(forKey: urlString as NSString) { //cache image existed
            self.image = image
        } else {
            guard let url = URL(string: urlString) else {
                return
            }
            
            if ImageDownloaderQueue.shared.didAddQueue(urlString) { //if url is not being downloded
                URLSession.shared.dataTask(with: url) { data, _, error in
                    DispatchQueue.main.async {
                        let imageToCache = UIImage(data: data!)
                        UIImageView.imageCache.setObject(imageToCache ?? UIImage(), forKey: urlString as NSString)
                        self.image = imageToCache
                        ImageDownloaderQueue.shared.removeQueue(urlString)
                        completion?()
                    }

                }.resume()
            }
        }
    }
}
