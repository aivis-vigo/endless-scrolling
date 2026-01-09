//
//  ContentView.swift
//  endless-scrolling
//
//  Created by Aivis Vigo Reimarts on 09/01/2026.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @StateObject private var vm = MediaViewModel()

    var body: some View {
        Text("Top").task {
            await vm.fetchTrendingImages()
        }
        
        List(vm.trendingResults) { image in
            Text(image.title)
        }
    }
}

#Preview {
    ContentView()
}
