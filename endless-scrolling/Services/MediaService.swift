//
//  MediaService.swift
//  endless-scrolling
//
//  Created by Aivis Vigo Reimarts on 09/01/2026.
//

import Foundation

protocol MediaServiceProtocol {
    func fetchTrendingImages()
}

class MediaService: MediaServiceProtocol {
    
    static let baseURL: String = "https://api.giphy.com/v1/gifs"
    
    func fetchTrendingImages() {
        print("Fetching Trending Images from: ", Self.baseURL)
    }
    
}
