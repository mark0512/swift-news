//
//  ImageDownloader.swift
//  SwiftNews
//
//  Created by Mark Kim on 2020-03-22.
//  Copyright © 2020 Mark. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {

    func getImage(urlString: String, completion: @escaping () -> ()) {
        self.image = nil
        
        if let image = imageCache.object(forKey: urlString as NSString) {
            self.image = image
        } else {
            guard let url = URL(string: urlString) else {
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, _, error in
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data!)
                    imageCache.setObject(imageToCache ?? UIImage(), forKey: urlString as NSString)
                    self.image = imageToCache
                    completion()
                }

            }.resume()
        }
    }
}
