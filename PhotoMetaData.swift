//
//  PhotoMetaData.swift
//  FlickrDemoTigerspike
//
//  Created by Krzysztof Maciążek on 20.02.2017.
//  Copyright © 2017 SOFTITI SP Z O O. All rights reserved.
//

import Foundation
import ObjectMapper

struct PhotoMetaData: Mappable {

    var title: String?
    var link: String?
    var dateTaken: String?
    var description: String?
    var published: String?
    var author: String?
    var tags: String?
    
    public init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        author <- map["author"]
        title <- map["title"]
        link <- map["link"]
        dateTaken <- map["date_taken"]
        description <- map["description"]
        tags <- map["tags"]
        published <- map["published"]
        
    }
}
