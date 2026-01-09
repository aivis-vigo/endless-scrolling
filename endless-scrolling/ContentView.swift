//
//  ContentView.swift
//  endless-scrolling
//
//  Created by Aivis Vigo Reimarts on 09/01/2026.
//

import SwiftData
import SwiftUI
import Combine

@MainActor
class ViewModel: ObservableObject {
    let mediaService: MediaService
    
//    @Published var trendingResults: [Gif] = []

    init() {
        self.mediaService = try! MediaService()
    }
    
    func fetchTrendingImages() async throws -> Void {
        let res = try await mediaService.fetchTrendingImages()
        print(res)
    }
}

struct ContentView: View {
    @StateObject private var vm = ViewModel()

    var body: some View {
        Text("Top").task {
            do {
                try await vm.fetchTrendingImages()
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
