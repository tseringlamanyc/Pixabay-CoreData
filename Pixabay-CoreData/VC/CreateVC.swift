//
//  CreateVC.swift
//  Pixabay-CoreData
//
//  Created by Tsering Lama on 4/13/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

protocol CreateVCDelegate: AnyObject {
    func userCreated(user: User, vc: CreateVC)
}

class CreateVC: UIViewController {
    
    
    @IBOutlet weak var userNameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func createPressed(_ sender: UIButton) {
    }
    
}
