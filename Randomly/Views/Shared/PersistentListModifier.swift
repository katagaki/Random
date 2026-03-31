//
//  PersistentListModifier.swift
//  Random
//
//  Created by Claude on 2026/03/31.
//

import SwiftUI

struct PersistentListModifier: ViewModifier {
    let key: String
    @Binding var items: [SelectItem]

    func body(content: Content) -> some View {
        content
            .onAppear {
                let loaded = ListStore.load(key: key)
                if !loaded.isEmpty {
                    items = loaded
                }
            }
            .onChange(of: items) {
                ListStore.save(key: key, items: items)
            }
    }
}

extension View {
    func persistItems(key: String, items: Binding<[SelectItem]>) -> some View {
        modifier(PersistentListModifier(key: key, items: items))
    }
}
