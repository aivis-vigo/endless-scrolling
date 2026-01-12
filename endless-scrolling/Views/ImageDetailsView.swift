//
//  ImageDetailsView.swift
//  endless-scrolling
//
//  Created by Aivis Vigo Reimarts on 11/01/2026.
//

import SwiftUI

struct ImageDetailsView: View {
    var details: Gif

    var body: some View {
        if let url = URL(string: details.images.original.url) {
            AnimatedImageLoader(
                imageURL: url
            )
            .aspectRatio(1, contentMode: .fit)
        } else {
            Text("Invalid Image URL")
        }
        Text(details.title)
        Text(details.username)
        Text(details.rating)
        Text(details.importDatetime)
    }
}
