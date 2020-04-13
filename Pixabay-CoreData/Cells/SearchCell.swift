//
//  SearchCell.swift
//  Pixabay-CoreData
//
//  Created by Tsering Lama on 4/13/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit
import ImageKit

class SearchCell: UICollectionViewCell {
    
    @IBOutlet weak var searchImage: UIImageView!
    
    private var urlString = ""
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // empty out image view (nil)
        searchImage.image = nil
    }
    
    func configureCell(photo: Photos) {
        
        self.urlString = photo.largeImageURL
        
        searchImage.getImage(with: urlString) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    if self?.urlString == self?.urlString {
                        self?.searchImage.image = image
                    }
                }
            }
        }
    }
    
}
