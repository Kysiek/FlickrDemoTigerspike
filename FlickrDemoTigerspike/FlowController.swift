//
//  FlowController.swift
//  FlickrDemoTigerspike
//
//  Created by Krzysztof Maciążek on 17.02.2017.
//  Copyright © 2017 SOFTITI SP Z O O. All rights reserved.
//


//Pattern with FlowController may be unnecessary in this small project, but I have used it to show in which way I structure navigation in my projects

import Foundation
import UIKit

class FlowController {
    
    var navigationController: UINavigationController!
    var photosService = PhotosService()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func startAppFlow() {
        let photosVC = PhotosViewController()
        photosVC.delegate = self
        photosVC.viewModel = PhotosViewModel(photosService: photosService)
        navigationController.setViewControllers([photosVC], animated: false)
    }
}

extension FlowController: PhotosViewControllerDelegate {
    func showDetailsViewController() {
        let detailsViewController = DetailsViewController()
        detailsViewController.delegate = self
        self.navigationController.pushViewController(detailsViewController, animated: true)
    }
}
extension FlowController: DetailsViewControllerDelegate {
    
}
