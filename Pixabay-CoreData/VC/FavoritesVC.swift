//
//  FavoritesVC.swift
//  Pixabay-CoreData
//
//  Created by Tsering Lama on 4/13/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {
    
    @IBOutlet weak var favoriteCV: UICollectionView!
    
    public var currentUser: User? {
        didSet {
            title = "\(currentUser?.name ?? "No User")'s Favorites"
        }
    }
    
    private var allFavorites = [Favorites]() {
        didSet {
            favoriteCV.reloadData()
            if allFavorites.isEmpty {
                favoriteCV.backgroundView = EmptyView(title: "No items", message: "No favorites yet")
            } else {
                favoriteCV.backgroundView = nil 
            }
        }
    }
    
    private var allUsers = [User]() {
        didSet {
            currentUser = allUsers.last
             allFavorites = CoreDataManager.shared.fetchFavorites(user: currentUser)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteCV.dataSource = self
        favoriteCV.delegate = self
        loadFavs()
    }
    
    private func loadFavs() {
        allUsers = CoreDataManager.shared.fetchUsers()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "create" {
            guard let createuserVC = segue.destination as? CreateVC else {
                fatalError()
            }
            createuserVC.delegate = self
        } else {
             guard let detailVC = segue.destination as? DetailVC, let indexpath = favoriteCV.indexPathsForSelectedItems?.first else {
                 fatalError()
             }
            detailVC.aFavorite = allFavorites[indexpath.row]
            detailVC.favButton.isEnabled = false 
        }
    }
}


extension FavoritesVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allFavorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favCell", for: indexPath) as? FavCell else {
            fatalError()
        }
        let aFav = allFavorites[indexPath.row]
        cell.configreCell(fav: aFav)
        return cell
    }
}

extension FavoritesVC: UICollectionViewDelegateFlowLayout {
    
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

extension FavoritesVC: CreateVCDelegate {
    func userCreated(user: User, vc: CreateVC) {
        allUsers.append(user)
    }
}

