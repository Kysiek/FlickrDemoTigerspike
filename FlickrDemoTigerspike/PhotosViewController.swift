//
//  PhotosViewController.swift
//  FlickrDemoTigerspike
//
//  Created by Krzysztof Maciążek on 17.02.2017.
//  Copyright © 2017 SOFTITI SP Z O O. All rights reserved.
//

import UIKit

protocol PhotosViewControllerDelegate: class {
    func showDetailsViewController()
}

class PhotosViewController: UIViewController {

    weak var delegate: PhotosViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showDetailsTapped(_ sender: Any) {
        delegate?.showDetailsViewController()
    }
}
