//
//  SearchImageView.swift
//  endless-scrolling
//
//  Created by Aivis Vigo Reimarts on 12/01/2026.
//

import SwiftUI

struct SearchImageView: View {
    @StateObject private var mediaViewModel = MediaViewModel()

    @State var searchPrompt: String = ""

    var body: some View {
        DynamicGrid {
            ForEach(
                Array(mediaViewModel.searchResults.enumerated()),
                id: \.offset
            ) { index, image in
                if let imageUrl = URL(string: image.images.original.url) {
                    NavigationLink(
                        destination: ImageDetailsView(details: image)
                    ) {
                        AnimatedImageLoader(
                            imageURL: imageUrl
                        )
                        .aspectRatio(1, contentMode: .fit)
                    }
                    .task {
                        guard let lastImage = mediaViewModel.searchResults.last
                        else { return }

                        if mediaViewModel.searchResults[index].id
                            == lastImage.id
                        {
                            Task {
                                await mediaViewModel.fetchImagesByQuery(
                                    string: searchPrompt
                                )
                            }
                        }
                    }
                }
            }
        }
        .searchable(text: $searchPrompt)
        .onChange(of: searchPrompt) { _, newValue in
            mediaViewModel.updateSearch(string: newValue)
        }
    }
}
