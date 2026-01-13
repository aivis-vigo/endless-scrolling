//
//  DynamicGridView.swift
//  endless-scrolling
//
//  Created by Aivis Vigo Reimarts on 09/01/2026.
//

import SwiftUI

struct DynamicGrid<Content: View>: View {
    let content: () -> Content
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var isLandscapeMode: Bool {
        verticalSizeClass == .compact
    }
    
    var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), alignment: nil), count: isLandscapeMode ? 3 : 2)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    content()
                }
            }
        }
    }
}
