//
//  DynamicGridView.swift
//  endless-scrolling
//
//  Created by Aivis Vigo Reimarts on 09/01/2026.
//

import SwiftUI

struct DynamicGrid<Content: View>: View {
    let content: () -> Content

    var body: some View {
        NavigationStack {
            Grid {
                ScrollView {
                    LazyVStack {
                        content()
                    }
                }
            }
        }
    }
}
