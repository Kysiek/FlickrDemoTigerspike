//
//  PhotosService.swift
//  FlickrDemoTigerspike
//
//  Created by Krzysztof Maciążek on 17.02.2017.
//  Copyright © 2017 SOFTITI SP Z O O. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper



class PhotosService {
    
    enum QueryParameters {
        case format
        case noJsonCallback
        case langugage
        case tagMode
        case tag
        
        var key: String {
            switch self {
            case .format: return "format"
            case .noJsonCallback: return "nojsoncallback"
            case .langugage: return "lang"
            case .tagMode: return "tagmode"
            case .tag: return "tags"
            }
        }
        
        var value: String {
            switch self {
            case .format: return "json"
            case .noJsonCallback: return "1"
            case .langugage: return "en-us"
            case .tagMode: return "all"
            case .tag: return ""
            }
        }
    }
    
    
    
    private static let necessaryParams: [String:String] = [
        QueryParameters.format.key: QueryParameters.format.value,
        QueryParameters.noJsonCallback.key: QueryParameters.noJsonCallback.value,
        QueryParameters.langugage.key: QueryParameters.langugage.value,
        QueryParameters.tagMode.key: QueryParameters.tagMode.value
    ]
    
    func getPhotosMetaData(having tag: String?, onSuccess successHandler: @escaping ([PhotoMetaData]) -> (), onError errorHandler: @escaping (AlertMessage) -> ()) {
        var params = PhotosService.necessaryParams
        
        if let tags = tag, tags.isEmpty == false {
            params[QueryParameters.tag.key] = tag
        }
        
        Alamofire.request(Configuration.Network.BASE_URL, parameters: params)
            .responseArray(keyPath: "items") { (response: DataResponse<[PhotoMetaData]>) in
                if let error = response.error {
                    errorHandler(AlertMessage(title: "Error", message: error.localizedDescription))
                } else {
                    if let responseArray = response.result.value {
                        successHandler(responseArray)
                    }
                }
            }
    }
    
}
