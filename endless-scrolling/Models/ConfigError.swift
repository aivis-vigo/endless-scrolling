//
//  ConfigError.swift
//  endless-scrolling
//
//  Created by Aivis Vigo Reimarts on 09/01/2026.
//

import Foundation

enum ConfigError: Error {
    case missingValue(key: String, file: String)

    var message: String {
        switch self {
        case .missingValue(let key, let file):
            return "Missing value in \(file) for key: \(key)"
        }
    }
}
