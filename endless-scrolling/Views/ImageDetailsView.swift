//
//  ImageDetailsView.swift
//  endless-scrolling
//
//  Created by Aivis Vigo Reimarts on 11/01/2026.
//

import SwiftUI

struct ImageDetailsView: View {
    @Binding var details: Gif?
    
    var body: some View {
        AnimatedImageLoader(
            imageURL: URL(string: details?.images.original.url ?? "")!
        )
        .aspectRatio(1, contentMode: .fit)
        Text(details?.title ?? "-")
        Text(details?.username ?? "-")
        Text(details?.rating ?? "-")
        Text(details?.importDatetime ?? "-")
    }
}
