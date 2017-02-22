//
//  PhotosViewController.swift
//  FlickrDemoTigerspike
//
//  Created by Krzysztof Maciążek on 17.02.2017.
//  Copyright © 2017 SOFTITI SP Z O O. All rights reserved.
//

import UIKit

protocol PhotosViewControllerDelegate: class {
    func showDetailsViewController(for photoMetaData: PhotoMetaData)
}

class PhotosViewController: UIViewController {

    weak var delegate: PhotosViewControllerDelegate?
    var viewModel: PhotosViewModel?
    
    @IBOutlet var dataSource: PhotosDataSource! {
        didSet {
            dataSource.targetViewController = self
        }
    }
    
    var searchController: UISearchController = UISearchController(searchResultsController: nil)
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ficklr demo"
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        dataSource.tableView.tableHeaderView = searchController.searchBar
        
        let sortButton = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortAction))
        self.navigationItem.rightBarButtonItem = sortButton
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(loadPhotos), for: .valueChanged)
        dataSource.tableView.addSubview(refreshControl)
        
        loadPhotos()
    }
    func sortAction() {
        let actionSheet = UIAlertController(title: "Sort photos", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "By published date", style: .default, handler: { _ in
            let photos = self.dataSource.photoMetaDataList
            self.dataSource.photoMetaDataList = photos?.sorted { elA, elB in
                return elA.publishedString!.compare(elB.publishedString!) == .orderedAscending
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "By taken date", style: .default, handler: { _ in
            let photos = self.dataSource.photoMetaDataList
            self.dataSource.photoMetaDataList = photos?.sorted { elA, elB in
                return elA.dateTakenString!.compare(elB.dateTakenString!) == .orderedAscending
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    func didSelect(photo: PhotoMetaData?) {
        if let photo = photo {
            delegate?.showDetailsViewController(for: photo)
        }
    }
    
    internal func loadPhotos() {
        self.dataSource.photoMetaDataList = []
        viewModel?.getPhotos(
            having: searchController.searchBar.text,
            onSuccess: { photoMetaDataList in
                DispatchQueue.main.async {
                    self.dataSource.photoMetaDataList = photoMetaDataList
                    self.refreshControl.endRefreshing()
                }
            },
            onError: { errorMessage in
                DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                    self.showInformation(containing: errorMessage, type: .error)
                }
            }
        )
    }
    
}
extension PhotosViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dataSource.scrollTableViewToTop()
        loadPhotos()
    }
}
