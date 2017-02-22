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
    var media: Media?
    var dateTakenString: String?
    var description: String?
    var publishedString: String?
    var author: String?
    var tags: String?
    
    lazy var dateTaken: Date? = {
        return self.date(from: self.dateTakenString)
    }()
    
    lazy var publishedDate: Date? = {
        if var publishedString = self.publishedString, let dateTakenString = self.dateTakenString {
            publishedString = publishedString.replacingOccurrences(of: "Z", with: String(dateTakenString.characters.suffix(6)))
            return self.date(from: publishedString)
        }
        return self.date(from: self.publishedString)
    }()
    
    lazy internal var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        return formatter
    }()
    lazy internal var prettyDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
        return formatter
    }()
    
    public init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        author <- map["author"]
        title <- map["title"]
        link <- map["link"]
        dateTakenString <- map["date_taken"]
        description <- map["description"]
        tags <- map["tags"]
        publishedString <- map["published"]
        media <- map["media"]
    }
    
    private mutating func date(from string: String?) -> Date? {
        if var dateString = string {
            dateString = dateString.replacingOccurrences(of: "T", with: " ")
            return dateFormatter.date(from: dateString)
        }
        return nil
    }
}
extension PhotoMetaData {
    func getImageUrl() -> String? {
        return media?.link
    }
    mutating func getPublishedDateString() -> String? {
        if let date = publishedDate {
            return prettyDateFormatter.string(from: date)
        }
        return publishedString
    }
    mutating func getDateTakenString() -> String? {
        if let date = dateTaken {
            return prettyDateFormatter.string(from: date)
        }
        return dateTakenString
    }
}
