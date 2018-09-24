//
//  Extension_UIImage.swift
//  APIBackedApp
//
//  Created by Tim Beals on 2018-09-24.
//  Copyright © 2018 Roobi Creative. All rights reserved.
//

import UIKit

extension UIImage {
    
    static let imageCache = NSCache<AnyObject, AnyObject>()
    
    static func cacheImage(from endPoint: String, completion: @escaping (UIImage?) -> ()) {
        
        APIService.fetchData(with: .image(endPoint: endPoint)) { (data, error) in
            
            guard error == nil else {
                print(error!.localizedDescription)
                completion(nil)
                return
            }
            
            guard let currData = data else {
                completion(nil)
                return
            }
            
            guard let image = UIImage(data: currData) else {
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                imageCache.setObject(image, forKey: endPoint as AnyObject)
            }
            
            completion(image)
        }
        
    }
}
