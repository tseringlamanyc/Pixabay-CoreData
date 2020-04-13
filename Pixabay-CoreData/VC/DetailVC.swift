//
//  DetailVC.swift
//  Pixabay-CoreData
//
//  Created by Tsering Lama on 4/13/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var views: UILabel!
    @IBOutlet weak var downloads: UILabel!
    @IBOutlet weak var favButton: UIBarButtonItem!
    @IBOutlet weak var tags: UILabel!
    @IBOutlet weak var url: UILabel!
    
    public var aPhoto: Photos?
    
    public var aFavorite: Favorites?
    
    public var currentUser: User?
    
    private var isFavorite = false {
        didSet {
            if isFavorite {
                favButton.image = UIImage(systemName: "heart.fill")
            } else {
                favButton.image = UIImage(systemName: "heart")
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        updateFavorites()
    }
    
    func updateUI() {
        guard let aPhoto = aPhoto else {
            return 
        }
        
        detailImage.getImage(with: aPhoto.largeImageURL) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.detailImage.image = image
                }
            }
        }
        
        likes.text = "Likes: \(aPhoto.likes.description)"
        views.text = "Views: \(aPhoto.views.description)"
        downloads.text = "Downloads: \(aPhoto.downloads.description)"
        tags.text = "Tags: \(aPhoto.tags ?? "N/A")"
        url.text = "PageURL: \(aPhoto.pageURL)"
    }
    
    func updateFavorites() {
        guard let aFavorite = aFavorite else {return}
        
        detailImage.getImage(with: aFavorite.photos ?? "") { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.detailImage.image = image
                }
            }
        }
    }
    

    @IBAction func favPressed(_ sender: UIBarButtonItem) {
        
        guard let aPhoto = aPhoto, let currentUser = currentUser else {return}
        
        print("Pressed")
        
        if isFavorite {
            _ = CoreDataManager.shared.saveFavorite(photo: aPhoto.largeImageURL, user: currentUser)
            showAlert(title: "Success", message: "Added to favorites")
        } else {
            CoreDataManager.shared.deleteFavorite(favorite: CoreDataManager.shared.saveFavorite(photo: aPhoto.largeImageURL, user: currentUser))
            showAlert(title: "Deleted", message: "Photo deleted")
        }
    }
}
