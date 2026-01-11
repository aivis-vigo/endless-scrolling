//
//  AnimatedImageLoader.swift
//  endless-scrolling
//
//  Created by Aivis Vigo Reimarts on 11/01/2026.
//

import SwiftUI
import Gifu

struct AnimatedImageLoader: UIViewRepresentable {
    let imageURL: URL
    
    func makeUIView(context: Context) -> GIFImageView {
        let imageView = GIFImageView()
        imageView.animate(withGIFURL: imageURL)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func updateUIView(_ uiView: GIFImageView, context: Context) {
    }
}
