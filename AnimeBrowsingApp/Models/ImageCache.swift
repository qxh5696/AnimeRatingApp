//
//  ImageCache.swift
//  AnimeBrowsingApp
//
//  Created by qh on 7/22/20.
//  Copyright © 2020 qadir haqq. All rights reserved.
//

import Foundation
import UIKit

class ImageCache {
    
    static let imageCacheKey = "ImageCache"
    
    static func storeImage(urlString: String, img: UIImage) {
        let path = NSTemporaryDirectory().appending(UUID().uuidString)
        let url = URL(fileURLWithPath: path)
        
        let data = img.jpegData(compressionQuality: 0.5)
        try? data?.write(to: url)
        
        var dict = UserDefaults.standard.object(forKey: imageCacheKey) as? [String:String]
        if dict == nil {
            dict = [String:String]()
        }
        dict![urlString] = path
        UserDefaults.standard.set(dict, forKey: imageCacheKey)
    }
    
    static func loadImage(urlString: String, completion: @escaping (String, UIImage) -> Void) {
        if let dict = UserDefaults.standard.object(forKey: imageCacheKey) as? [String:String] {
            if let path = dict[urlString] {
                if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                    let img = UIImage(data: data)!
                    completion(urlString, img)
                }
            }
        }
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if (error != nil) {
                print(error)
                return
            }
            guard let d = data else { return }
            DispatchQueue.main.async {
                if let image = UIImage(data: d) {
                    completion(urlString, image)
                }
            }
        }).resume()
    }
    
}
