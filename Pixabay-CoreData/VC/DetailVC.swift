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
    
    private var aPhoto: Photos
    
    init?(coder: NSCoder, photo: Photos) {
        self.aPhoto = photo
        super.init(coder:coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func favPressed(_ sender: UIBarButtonItem) {
    }
}
