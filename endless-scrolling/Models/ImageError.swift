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
    case noInternetConnection
    case timeout
    case rateLimitExceeded

    var message: String {
        switch self {
        case .invalidURL:
            return "The URL is invalid or malformed"
        case .invalidResponse:
            return "The response from the API was invalid"
        case .invalidData:
            return "Data from the response was invalid"
        case .noInternetConnection:
            return "No internet connection. Check your network settings"
        case .timeout:
            return "The request timed out. Try again"
        case .rateLimitExceeded:
            return "The rate limit for this API key has been exceeded. Try again later"
        }
    }
}
