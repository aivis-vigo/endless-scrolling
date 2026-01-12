//
//  ContentView.swift
//  endless-scrolling
//
//  Created by Aivis Vigo Reimarts on 09/01/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TrendingView()
                .tabItem { Label("Home", systemImage: "house") }
            SearchImageView()
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
        }
    }
}

#Preview {
    ContentView()
}
