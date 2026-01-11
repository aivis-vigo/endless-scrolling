//
//  MediaService.swift
//  endless-scrolling
//
//  Created by Aivis Vigo Reimarts on 09/01/2026.
//

import Foundation

// TODO: network availability handling (lack of internet connectivity)

final class MediaService: MediaServiceProtocol, Sendable {

    static let baseURL: String = "https://api.giphy.com/v1/gifs"
    private let apiKey: String
    private var offset: Int = 0

    init() throws {
        self.apiKey = try ConfigManager.getValue(forKey: "GIPHY_API_KEY")
    }

    func fetchTrendingImages(limit: Int = 25) async throws
        -> [Gif]
    {
        let endpoint =
            "\(Self.baseURL)/trending?api_key=\(self.apiKey)&limit=\(limit)&offset=\(offset)&rating=g&bundle=messaging_non_clips"

        guard let url = URL(string: endpoint) else {
            throw GiphyError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse,
            response.statusCode == 200
        else {
            throw GiphyError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let res = try decoder.decode(GiphyResponse.self, from: data)
            
            Task { @MainActor in
                self.offset += res.data.count
            }
            
            return Array(res.data)
        } catch {
            throw GiphyError.invalidData
        }
    }

}
