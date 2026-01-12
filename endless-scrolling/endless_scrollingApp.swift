//
//  endless_scrollingApp.swift
//  endless-scrolling
//
//  Created by Aivis Vigo Reimarts on 09/01/2026.
//

import SwiftData
import SwiftUI

@main
struct endless_scrollingApp: App {
    @StateObject private var networkMonitor = NetworkMonitor()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(networkMonitor)
        }
    }
}
