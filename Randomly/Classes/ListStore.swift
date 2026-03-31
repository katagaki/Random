//
//  ListStore.swift
//  Random
//
//  Created by Claude on 2026/03/31.
//

import Foundation

enum ListStore {

    private static let defaults = UserDefaults.standard

    static func save(key: String, items: [SelectItem]) {
        if let data = try? JSONEncoder().encode(items) {
            defaults.set(data, forKey: key)
        }
    }

    static func load(key: String) -> [SelectItem] {
        guard let data = defaults.data(forKey: key),
              let items = try? JSONDecoder().decode([SelectItem].self, from: data) else {
            return []
        }
        return items
    }
}
