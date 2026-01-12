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
    @Published var searchResults: [Gif] = []

    @Published var errorMessage: String?

    private var userInputSearchSubject = PassthroughSubject<String, Never>()
    private var cancellables = Set<AnyCancellable>()

    init() {
        self.mediaService = try! MediaService()

        userInputSearchSubject.debounce(for: 0.5, scheduler: RunLoop.main).sink
        { [weak self] prompt in
            self?.trendingResults.removeAll()
            Task {
                await self?.fetchImagesByQuery(string: prompt)
            }
        }.store(in: &cancellables)
    }

    func fetchTrendingImages() async {
        do {
            let res = try await mediaService.fetchTrendingImages()
            self.trendingResults.append(contentsOf: res)
        } catch {
            self.errorMessage = error.localizedDescription
            print(
                "Error fetching images in MediaViewModel:fetchTrendingImages : \(error)"
            )
        }
    }

    func fetchImagesByQuery(string: String) async {
        do {
            let res = try await mediaService.fetchImagesByQuery(string: string)
            self.searchResults.append(contentsOf: res)
        } catch {
            self.errorMessage = error.localizedDescription
            print("Error fetching images in MediaViewModel:fetchImagesByQuery")
        }
    }

    func updateSearch(string userInput: String) {
        self.userInputSearchSubject.send(userInput)
    }
}
