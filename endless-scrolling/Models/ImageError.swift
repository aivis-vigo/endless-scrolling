//
//  ImageError.swift
//  endless-scrolling
//
//  Created by Aivis Vigo Reimarts on 09/01/2026.
//

import Foundation

enum GiphyError: Error {
    case invalidURL
    case invalidResponse
    case invalidData

    var message: String {
        switch self {
        case .invalidURL:
            return "The URL is invalid or malformed"
        case .invalidResponse:
            return "The response from the API was invalid"
        case .invalidData:
            return "Data from the response was invalid"
        }
    }
}
