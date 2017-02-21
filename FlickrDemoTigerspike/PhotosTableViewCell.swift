//
//  PhotosTableViewCell.swift
//  FlickrDemoTigerspike
//
//  Created by Krzysztof Maciążek on 20.02.2017.
//  Copyright © 2017 SOFTITI SP Z O O. All rights reserved.
//

import UIKit
import SDWebImage

class PhotosTableViewCell: UITableViewCell {

    static let identifier: String = "PhotosTableViewCell"
    @IBOutlet weak var photoImageView: UIImageView!
    
    func setupCellImage(from urlString: String?) {
        if let imageUrl = urlString {
            photoImageView.setShowActivityIndicator(true)
            photoImageView.setIndicatorStyle(.gray)
            photoImageView.sd_setImage(with: URL(string: imageUrl))
        }
    }
}
