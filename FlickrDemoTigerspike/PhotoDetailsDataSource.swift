//
//  PhotoDetailsDataSource.swift
//  FlickrDemoTigerspike
//
//  Created by Krzysztof Maciążek on 21.02.2017.
//  Copyright © 2017 SOFTITI SP Z O O. All rights reserved.
//

import UIKit

enum PhotoDetailsTableLayout: Int {
    case photo
    case title = 1
    case author
    case dateTaken
    case tags
    case published
    case description
    
    static let rowHeight: CGFloat = 44.0
    static let sectionsCount: Int = 7
    
    init(indexPath: IndexPath) {
        switch indexPath {
        case PhotoDetailsTableLayout.photo.indexPath: self = .photo
        case PhotoDetailsTableLayout.title.indexPath: self = .title
        case PhotoDetailsTableLayout.author.indexPath: self = .author
        case PhotoDetailsTableLayout.dateTaken.indexPath: self = .dateTaken
        case PhotoDetailsTableLayout.tags.indexPath: self = .tags
        case PhotoDetailsTableLayout.published.indexPath: self = .published
        case PhotoDetailsTableLayout.description.indexPath: self = .description
        default: self = .author
        }
    }
    
    init?(section: Int) {
        switch IndexPath(row: 0, section: section) {
        case PhotoDetailsTableLayout.title.indexPath: self = .title
        case PhotoDetailsTableLayout.author.indexPath: self = .author
        case PhotoDetailsTableLayout.dateTaken.indexPath: self = .dateTaken
        case PhotoDetailsTableLayout.tags.indexPath: self = .tags
        case PhotoDetailsTableLayout.published.indexPath: self = .published
        case PhotoDetailsTableLayout.description.indexPath: self = .description
        default: return nil
        }
    }
    
    var indexPath: IndexPath {
        return IndexPath(row: 0, section: rawValue)
    }
    
    var rowHeight: CGFloat {
        switch self {
        case .photo: return 300.0
        default: return 44.0
        }
    }
    var headerHeight: CGFloat {
        switch self {
        case .photo: return 0.0
        default: return 60.0
        }
    }
    var title: String {
        switch self {
            case .photo: return ""
            case .title: return "TITLE"
            case .author: return "AUTHOR"
            case .dateTaken: return "DATA TAKEN"
            case .tags: return "TAGS"
            case .published: return "PUBLISHED DATE"
            case .description: return "DESCRIPTION"
        }
    }
    
    func value(photoMetaData: PhotoMetaData?) -> String? {
        switch self {
        case .photo: return photoMetaData?.getImageUrl()
        case .title: return photoMetaData?.title
        case .author: return photoMetaData?.author
        case .dateTaken: return photoMetaData?.dateTaken
        case .tags: return photoMetaData?.tags
        case .published: return photoMetaData?.published
        case .description: return photoMetaData?.description
        }
    }
    
    
}

class PhotoDetailsDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var photoMetaData: PhotoMetaData?
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "DetailPhotoCell", bundle: nil), forCellReuseIdentifier: DetailPhotoCell.identifier)
            tableView.register(UINib(nibName: "PhotosTableViewCell", bundle: nil), forCellReuseIdentifier: PhotosTableViewCell.identifier)
            tableView.register(UINib(nibName: "PhotoDetailHeaderCell", bundle: nil), forCellReuseIdentifier: PhotoDetailHeaderCell.identifier)
        }
    }
    func getImage() -> UIImage? {
        if let photoCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? PhotosTableViewCell, let image = photoCell.photoImageView.image {
            return image
        }
        return nil
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return PhotoDetailsTableLayout.sectionsCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellEnum = PhotoDetailsTableLayout(indexPath: indexPath)
        let cell: UITableViewCell!
        if cellEnum == .photo {
            cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as? PhotosTableViewCell
            (cell as? PhotosTableViewCell)?.setupCellImage(from: cellEnum.value(photoMetaData: photoMetaData!))
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: DetailPhotoCell.identifier, for: indexPath) as? DetailPhotoCell
            (cell as? DetailPhotoCell)?.detailLabel.text = cellEnum.value(photoMetaData: photoMetaData)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoDetailHeaderCell.identifier) as? PhotoDetailHeaderCell
        if let section = PhotoDetailsTableLayout(section: section), let headerCell = cell {
            headerCell.headerLabel.text = section.title
            return headerCell
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PhotoDetailsTableLayout(indexPath: indexPath).rowHeight
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return PhotoDetailsTableLayout(indexPath: IndexPath(row: 0, section: section)).headerHeight
    }
}
