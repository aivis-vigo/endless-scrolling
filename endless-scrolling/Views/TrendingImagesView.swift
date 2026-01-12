//
//  TrendingImagesView.swift
//  endless-scrolling
//
//  Created by Aivis Vigo Reimarts on 09/01/2026.
//

import Network
import SwiftUI

struct TrendingView: View {
    @StateObject private var mediaViewModel = MediaViewModel()
    @EnvironmentObject var networkMontior: NetworkMonitor

    var body: some View {
        switch networkMontior.path?.status {
        case .satisfied:
            DynamicGrid {
                ForEach(
                    Array(mediaViewModel.trendingResults.enumerated()),
                    id: \.offset
                ) { index, image in
                    NavigationLink(
                        destination: ImageDetailsView(details: image)
                    ) {
                        if let imageUrl = URL(
                            string: image.images.original.url
                        ) {
                            AnimatedImageLoader(
                                imageURL: imageUrl
                            )
                            .aspectRatio(1, contentMode: .fit)
                            .task {
                                guard
                                    let lastImage = mediaViewModel
                                        .trendingResults
                                        .last
                                else { return }
                                if mediaViewModel.trendingResults[index].id
                                    == lastImage.id
                                {
                                    Task {
                                        await mediaViewModel
                                            .fetchTrendingImages()
                                    }
                                }
                            }
                        }
                    }
                }
            }.task {
                await mediaViewModel.fetchTrendingImages()
            }
        case .unsatisfied:
            Text("You're not connected")
        case .requiresConnection:
            Text("Connecting...")
        default:
            Text("Content Unknown")
        }
    }
}
