//
//  PixabayClient.swift
//  Pixabay-CoreData
//
//  Created by Tsering Lama on 4/13/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import Foundation
import NetworkHelper

struct APIClient {
    static func getPhotos(search: String, completionHandler: @escaping (Result<[Photos], AppError>) -> ()) {
        let endpointUrl = "https://pixabay.com/api/?key=\(Apikey.key)&q=\(search)"
        
        guard let url = URL(string: endpointUrl) else {
            completionHandler(.failure(.badURL(endpointUrl)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completionHandler(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let photoData = try JSONDecoder().decode(Pixabay.self, from: data)
                    completionHandler(.success(photoData.hits))
                } catch {
                    completionHandler(.failure(.decodingError(error)))
                }
            }
        }
    }
}
