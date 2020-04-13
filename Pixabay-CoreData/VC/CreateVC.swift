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
    
    weak var delegate: CreateVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func createPressed(_ sender: UIButton) {
        guard let userName = userNameTF.text, !userName.isEmpty else {
            showAlert(title: "Error", message: "Please enter a username")
            return
        }
        
        let createdUser = CoreDataManager.shared.createNewUser(name: userName)
        delegate?.userCreated(user: createdUser, vc: self)
        dismiss(animated: true)
    }
    
}
