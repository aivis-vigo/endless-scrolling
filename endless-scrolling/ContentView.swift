//
//  ContentView.swift
//  endless-scrolling
//
//  Created by Aivis Vigo Reimarts on 09/01/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    private let mediaService = MediaService();
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        Text("Top").onAppear {
            mediaService.fetchTrendingImages()
        };
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
