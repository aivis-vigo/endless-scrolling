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
                            string: image.images.fixedHeight.url
                        ) {
                            ZStack(alignment: .bottom){
                                AnimatedImageLoader(
                                    imageURL: imageUrl
                                )
                                .accessibilityIdentifier("trendingGif_\(index)")
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity)
                                .clipped()
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
                                
                                Text(image.title)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .foregroundColor(.black)
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 8)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(.white.opacity(0.8))
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.black, lineWidth: 2)
                            )
                        }
                    }
                }
                .padding(.horizontal, 6)
            }
            .accessibilityIdentifier("trendingImagesGrid")
            .task {
                await mediaViewModel.fetchTrendingImages()
            }
        case .unsatisfied:
            VStack {
                Label("You're not connected", systemImage: "wifi.slash")
            }
        case .requiresConnection:
            Text("Connecting...")
        default:
            Text("Content Unknown")
        }
    }
}
