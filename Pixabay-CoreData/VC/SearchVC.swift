//
//  SearchVC.swift
//  Pixabay-CoreData
//
//  Created by Tsering Lama on 4/13/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    @IBOutlet weak var photoSearchBar: UISearchBar!
    @IBOutlet weak var searchCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoSearchBar.delegate = self
        searchCV.dataSource = self
        searchCV.delegate = self
    }
    
    public var searchImages = [Photos]() {
        didSet {
            DispatchQueue.main.async {
                self.searchCV.reloadData()
                if self.searchImages.isEmpty {
                    self.searchCV.backgroundView = EmptyView(title: "No favorites", message: "Add favorites")
                } else {
                    self.searchCV.backgroundView = nil
                }
            }
        }
    }
    
    public var currentSearch = "" {
        didSet {
            loadData(userSearch: currentSearch)
        }
    }
    
    public func loadData(userSearch: String) {
        APIClient.getPhotos(search: userSearch) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let data):
                self?.searchImages = data
            }
        }
    }
}

extension SearchVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentSearch = searchBar.text!
    }
}

extension SearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? SearchCell else {
            fatalError()
        }
        let aPhoto = searchImages[indexPath.row]
        cell.configureCell(photo: aPhoto)
        return cell
    }
}

extension SearchVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interspacing = CGFloat(5)
        let maxwidth = UIScreen.main.bounds.size.width
        let numOfItems = CGFloat(3)
        let totalSpacing = CGFloat(numOfItems * interspacing)
        let itemWidth = CGFloat((maxwidth - totalSpacing) / (numOfItems) )
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 3, bottom: 5, right: 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
