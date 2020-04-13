//
//  FavCell.swift
//  Pixabay-CoreData
//
//  Created by Tsering Lama on 4/13/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit
import ImageKit

class FavCell: UICollectionViewCell {
    
    @IBOutlet weak var favImage: UIImageView!
    
    func configreCell(fav: Favorites) {
        favImage.getImage(with: fav.photos ?? "") { [weak self ](result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.favImage.image = image
                }
            }
        }
    }
}
