//
//  Struct.swift
//  FlickrDemoTigerspike
//
//  Created by Krzysztof Maciążek on 21.02.2017.
//  Copyright © 2017 SOFTITI SP Z O O. All rights reserved.
//

import Foundation
import ObjectMapper

struct Media: Mappable {
    var link: String?
    
    public init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        link <- map["m"]
    }
}
