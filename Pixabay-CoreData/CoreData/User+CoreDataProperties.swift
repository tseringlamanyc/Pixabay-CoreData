//
//  User+CoreDataProperties.swift
//  Pixabay-CoreData
//
//  Created by Tsering Lama on 4/13/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var favorites: NSSet?

}

// MARK: Generated accessors for favorites
extension User {

    @objc(addFavoritesObject:)
    @NSManaged public func addToFavorites(_ value: Favorites)

    @objc(removeFavoritesObject:)
    @NSManaged public func removeFromFavorites(_ value: Favorites)

    @objc(addFavorites:)
    @NSManaged public func addToFavorites(_ values: NSSet)

    @objc(removeFavorites:)
    @NSManaged public func removeFromFavorites(_ values: NSSet)

}
