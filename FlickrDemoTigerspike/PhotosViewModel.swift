//
//  PhotosViewModel.swift
//  FlickrDemoTigerspike
//
//  Created by Krzysztof Maciążek on 17.02.2017.
//  Copyright © 2017 SOFTITI SP Z O O. All rights reserved.
//

import Foundation

class PhotosViewModel {
    
    let photosService: PhotosService
    
    init(photosService: PhotosService) {
        self.photosService = photosService
    }
    
    func getPhotos(having tag: String?,
                   onSuccess successHandler: @escaping ([PhotoMetaData]) -> (),
                   onError errorHandler: @escaping (AlertMessage) -> ()) {
        
        photosService.getPhotosMetaData(
            having: tag,
            onSuccess: { photoMetaDataList in successHandler(photoMetaDataList) },
            onError: { errorMessage in errorHandler(errorMessage) }
        )
    }
}
