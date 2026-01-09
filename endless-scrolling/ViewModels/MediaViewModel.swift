//
//  MediaViewModel.swift
//  endless-scrolling
//
//  Created by Aivis Vigo Reimarts on 09/01/2026.
//

import Combine
import Foundation

@MainActor
class MediaViewModel: ObservableObject {
    let mediaService: MediaService

    @Published var trendingResults: [Gif] = []
    @Published var errorMessage: String?

    init() {
        self.mediaService = try! MediaService()
    }

    func fetchTrendingImages() async {
        do {
            let res = try await mediaService.fetchTrendingImages()
            self.trendingResults.append(contentsOf: res)
        } catch {
            self.errorMessage = error.localizedDescription
            print(
                "Error fetching images in MediaVieModel:fetchTrendingImages : \(error)"
            )
        }
    }
}
