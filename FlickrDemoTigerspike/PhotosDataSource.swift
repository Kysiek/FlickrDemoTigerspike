//
//  PhotosDataSource.swift
//  FlickrDemoTigerspike
//
//  Created by Krzysztof Maciążek on 20.02.2017.
//  Copyright © 2017 SOFTITI SP Z O O. All rights reserved.
//

import UIKit

class PhotosDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private let ROW_HEIGHT: CGFloat = 300.0
    weak var targetViewController: PhotosViewController?
    
    var photoMetaDataList: [PhotoMetaData]? {
        didSet {
            if let oldCount = oldValue?.count, oldCount > 0 {
                
                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .middle, animated: true)
            }
            reloadData()
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "PhotosTableViewCell", bundle: nil), forCellReuseIdentifier: PhotosTableViewCell.identifier)
        }
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoMetaDataList?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let photoCell = cell as? PhotosTableViewCell, let photoMetaData = photoMetaDataList?[indexPath.row] {
            photoCell.setupCellImage(from: photoMetaData.getImageUrl())
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ROW_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        targetViewController?.didSelect(photo: photoMetaDataList?[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
