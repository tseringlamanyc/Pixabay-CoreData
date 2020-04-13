//
//  PIxabay-Model.swift
//  Pixabay-CoreData
//
//  Created by Tsering Lama on 4/13/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import Foundation

struct Pixabay: Codable {
    let hits: [Photos]
}

struct Photos: Codable, Equatable {
    let largeImageURL: String
    let likes: Int
    let views: Int
    let pageURL: String
    let downloads: Int
    let tags: String?
}
