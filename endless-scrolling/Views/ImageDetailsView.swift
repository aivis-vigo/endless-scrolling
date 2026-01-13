//
//  ImageDetailsView.swift
//  endless-scrolling
//
//  Created by Aivis Vigo Reimarts on 11/01/2026.
//

import Network
import SwiftUI

struct ImageDetailsView: View {
    @EnvironmentObject var networkMontior: NetworkMonitor
    @Environment(\.verticalSizeClass) var verticalSizeClass

    var details: Gif
    
    var isLandscapeMode: Bool {
        verticalSizeClass == .compact
    }

    var body: some View {
        switch networkMontior.path?.status {
        case .satisfied:
            if isLandscapeMode {
                HStack {
                    VStack {
                        if let url = URL(string: details.images.original.url) {
                            AnimatedImageLoader(
                                imageURL: url
                            )
                            .accessibilityIdentifier("selectedGif")
                            .aspectRatio(1, contentMode: .fit)
                        } else {
                            Text("Invalid Image URL")
                        }
                    }
                    VStack {
                        Text(details.title)
                        Text(details.username)
                        Text(details.rating)
                        Text(details.importDatetime)
                    }
                }
            } else {
                VStack {
                    if let url = URL(string: details.images.original.url) {
                        AnimatedImageLoader(
                            imageURL: url
                        )
                        .accessibilityIdentifier("selectedGif")
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
