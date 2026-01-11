//
//  TrendingImagesView.swift
//  endless-scrolling
//
//  Created by Aivis Vigo Reimarts on 09/01/2026.
//

import SwiftUI

struct TrendingView: View {
    @StateObject private var mediaViewModel = MediaViewModel()
    @State var selectedImage: Gif?

    var body: some View {
        DynamicGrid {
            ForEach(
                Array(mediaViewModel.trendingResults.enumerated()),
                id: \.offset
            ) { index, image in
                NavigationLink(destination: ImageDetailsView(details: $selectedImage)) {
                    AnimatedImageLoader(
                        imageURL: URL(string: image.images.original.url)!
                    )
                    .aspectRatio(1, contentMode: .fit)
                    .simultaneousGesture(TapGesture().onEnded {
                        selectedImage = image
                    })
                    .task {
                        guard
                            let lastImage = mediaViewModel.trendingResults.last
                        else { return }
                        if mediaViewModel.trendingResults[index].id
                            == lastImage.id
                        {
                            Task {
                                await mediaViewModel.fetchTrendingImages()
                            }
                        }
                    }
                }
            }
        }.task {
            await mediaViewModel.fetchTrendingImages()
        }
    }
}
