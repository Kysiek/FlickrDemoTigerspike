//
//  PhotosManager.swift
//  FlickrDemoTigerspike
//
//  Created by Krzysztof Maciążek on 17.02.2017.
//  Copyright © 2017 SOFTITI SP Z O O. All rights reserved.
//


import Foundation
import UIKit

class PhotoManager {
    let cache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()
    
    func getPhoto(from urlString: String) -> UIImage {
        if let photoFromCache = cache.object(forKey: urlString as NSString) {
            return photoFromCache
        } else {
            
        }
    }
}
