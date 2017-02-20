//
//  PhotosResponse.swift
//  FlickrDemoTigerspike
//
//  Created by Krzysztof Maciążek on 20.02.2017.
//  Copyright © 2017 SOFTITI SP Z O O. All rights reserved.
//

import Foundation
import ObjectMapper

struct PhotosResponse: Mappable {
    
    var photoMetaDataList: [PhotoMetaData]?
    
    public init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        photoMetaDataList <- map["items"]
    }
}
