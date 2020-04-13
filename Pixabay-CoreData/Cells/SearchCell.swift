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
    
    func configureCell(photo: Photos) {
        searchImage.getImage(with: photo.largeImageURL) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.searchImage.image = image
                }
            }
        }
    }
    
}
