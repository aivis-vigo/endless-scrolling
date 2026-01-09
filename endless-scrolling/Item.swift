//
//  Item.swift
//  endless-scrolling
//
//  Created by Aivis Vigo Reimarts on 09/01/2026.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
