//
//  FlowController.swift
//  FlickrDemoTigerspike
//
//  Created by Krzysztof Maciążek on 17.02.2017.
//  Copyright © 2017 SOFTITI SP Z O O. All rights reserved.
//


//Pattern with FlowController may be unnecessary in this small project, but I have used it to show in which way I structure navigation in my projects

import UIKit
import MessageUI

class FlowController: NSObject {
    
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
    internal func showDetailsViewController(for photoMetaData: PhotoMetaData) {
        let detailsViewController = DetailsViewController()
        detailsViewController.delegate = self
        detailsViewController.photoMetaData = photoMetaData
        self.navigationController.pushViewController(detailsViewController, animated: true)
    }
}
extension FlowController: DetailsViewControllerDelegate {

    func sendMail(with image: UIImage, imageName: String) {
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setSubject("e-mail with photo")
        mailComposer.setMessageBody("Some text body", isHTML: false)
        
        if let imageData = UIImagePNGRepresentation(image) {
            mailComposer.addAttachmentData(imageData, mimeType: "image/png", fileName: imageName)
            navigationController.present(mailComposer, animated: true, completion: nil)
        } else {
            navigationController.presentedViewController?.showInformation(containing: AlertMessage(title: "Error", message: "S-th went wrong during converting UIImage to Data"), type: .error)
        }
    }
    func openBrowser(with link: String) {
        if let url = URL(string: link) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            navigationController.presentedViewController?.showInformation(containing: AlertMessage(title: "Error", message: "Could not open in the browser"), type: .error)
        }
    }
}
extension FlowController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
