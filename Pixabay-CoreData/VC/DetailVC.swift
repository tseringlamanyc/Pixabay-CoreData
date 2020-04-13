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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
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
    

    @IBAction func favPressed(_ sender: UIBarButtonItem) {
        
    }
}
