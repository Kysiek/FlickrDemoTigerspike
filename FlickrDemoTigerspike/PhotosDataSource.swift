//
//  PhotosDataSource.swift
//  FlickrDemoTigerspike
//
//  Created by Krzysztof Maciążek on 20.02.2017.
//  Copyright © 2017 SOFTITI SP Z O O. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class PhotosDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private let ROW_HEIGHT: CGFloat = 300.0
    weak var targetViewController: PhotosViewController?
    
    var photoMetaDataList: [PhotoMetaData]? {
        didSet {
            if let oldCount = oldValue?.count, oldCount > 0 {
            }
            reloadData()
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "PhotosTableViewCell", bundle: nil), forCellReuseIdentifier: PhotosTableViewCell.identifier)
            tableView.emptyDataSetDelegate = self
            tableView.emptyDataSetDelegate = self
        }
    }
    func scrollTableViewToTop() {
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .middle, animated: true)
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
extension PhotosDataSource: DZNEmptyDataSetDelegate {
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor(red:0.51, green:0.53, blue:0.55, alpha:1.00)
    }
}
extension PhotosDataSource: DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let params = [
            NSForegroundColorAttributeName: UIColor(red:0.02, green:0.06, blue:0.09, alpha:1.00),
            NSFontAttributeName: UIFont(name: "Raleway-Bold", size: 17.0)!
        ]
        return NSAttributedString(string: "Loading data", attributes: params)
    }
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let params = [
            NSForegroundColorAttributeName: UIColor(red:0.02, green:0.06, blue:0.09, alpha:1.00),
            NSFontAttributeName: UIFont(name: "Raleway-Light", size: 17.0)!
        ]
        return NSAttributedString(string: "Please wait while data is loading", attributes: params)
    }
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "photos")
    }
}
