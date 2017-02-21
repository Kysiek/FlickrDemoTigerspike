//
//  DetailsViewController.swift
//  FlickrDemoTigerspike
//
//  Created by Krzysztof Maciążek on 17.02.2017.
//  Copyright © 2017 SOFTITI SP Z O O. All rights reserved.
//

import UIKit
import Photos
import MessageUI

protocol DetailsViewControllerDelegate: class {
    func sendMail(with image: UIImage, imageName: String)
    func openBrowser(with link: String)
}

class DetailsViewController: UIViewController {

    weak var delegate: DetailsViewControllerDelegate?
    @IBOutlet var dataSource: PhotoDetailsDataSource! {
        didSet {
            dataSource.photoMetaData = photoMetaData
        }
    }
    var photoMetaData: PhotoMetaData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photo details"
        
        let rightButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showActionSheet))
        
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    func showActionSheet() {
        let actionSheet = UIAlertController(title: "Choose an option", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Save on disc", style: .default, handler: { _ in self.saveAction()}))
        actionSheet.addAction(UIAlertAction(title: "Open in browser", style: .default, handler: { _ in self.browserAction()}))
        actionSheet.addAction(UIAlertAction(title: "Send as attachement", style: .default, handler: { _ in self.emailAction()}))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func saveAction() {
        if let imageToSave = dataSource.getImage() {
            
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAsset(from: imageToSave)
            }, completionHandler: { success, error in
                DispatchQueue.main.async {
                    if success {
                        self.showInformation(containing: AlertMessage(title: "Success", message: "Photo has been sucessfully saved!"), type: .success)
                    }
                    else if let error = error {
                        self.showInformation(containing: AlertMessage(title: "Error", message: error.localizedDescription), type: .error)
                    }
                    else {
                        self.showInformation(containing: AlertMessage(title: "Error", message: "Something went wrong"), type: .error)
                    }
                }
            })
        }
        
    }
    
    func emailAction() {
        if let imageToSave = dataSource.getImage() {
            delegate?.sendMail(with: imageToSave, imageName: photoMetaData?.title ?? "default")
        }
    }

    func browserAction() {
        if let linkToOpen = photoMetaData?.link {
            delegate?.openBrowser(with: linkToOpen)
        }
    }
}
