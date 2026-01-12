//
//  GifModel.swift
//  endless-scrolling
//
//  Created by Aivis Vigo Reimarts on 09/01/2026.
//

import Foundation

struct GiphyResponse: Codable {
    let data: [Gif]
}

struct Gif: Identifiable, Codable {
    let id: String
    let title: String
    let username: String
    let importDatetime: String
    let rating: String
    let images: Images
}

struct Images: Codable {
    let original: Original
    let fixedHeight: FixedHeight
}

struct Original: Codable {
    let url: String
    let height: String
    let width: String
}

struct FixedHeight: Codable {
    let url: String
    let height: String
    let width: String
}
