//
//  CoreDataManager.swift
//  Pixabay-CoreData
//
//  Created by Tsering Lama on 4/13/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    private var users = [User]()
    private var favs = [Favorites]()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    public func createNewUser(name: String) -> User {
        let user = User(entity: User.entity(), insertInto: context)
        user.name = name
        
        do {
            try context.save()
        } catch {
            print("Error saving user: \(error)")
        }
        return user
    }
    
    public func fetchUsers() -> [User] {
        do {
            users = try context.fetch(User.fetchRequest())
        } catch {
            print("Error fetching users: \(error)")
        }
        return users
    }
    
    public func saveFavorite(photo: String, user: User) -> Favorites {
        
        let favorite = Favorites(entity: Favorites.entity(), insertInto: context)
        favorite.user = user
        favorite.photos = photo
        
        do {
            try context.save()
        } catch {
            print("Error saving fav: \(error)")
        }
        
        return favorite
    }
    
    public func fetchFavorites(user: User?) -> [Favorites] {
        if user != nil {
            do {
                favs = try context.fetch(Favorites.fetchRequest())
            } catch {
                print("Error fetching favorites: \(error)")
            }
        } else {
            print("no current user")
        }
        return favs
    }
    
}
