//
//  ConfigManager.swift
//  endless-scrolling
//
//  Created by Aivis Vigo Reimarts on 09/01/2026.
//

import Foundation

enum ConfigManager {
    static func getValue(forKey key: String, in file: String = "secret-config")
        throws -> String
    {
        guard let path = Bundle.main.path(forResource: file, ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path),
            let value = dict[key] as? String, !value.isEmpty
        else {
            fatalError("Missing value in \(file) for key: \(key)")
        }
        return value
    }
}
