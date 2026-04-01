//
//  GenerateUUIDView.swift
//  Random
//
//  Created by Claude on 2026/04/01.
//

import SwiftUI

struct GenerateUUIDView: View {

    @State var generatedUUID: String = ""

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            ScrollView(.horizontal) {
                Text(generatedUUID)
                    .font(.system(size: 30, weight: .heavy, design: .monospaced))
                    .lineLimit(1)
                    .textSelection(.enabled)
                    .padding()
                    .contentTransition(.numericText())
            }
            .scrollIndicators(.hidden)
            Spacer()
        }
        .task {
            regenerate()
        }
        .randomlyNavigation(title: "Generate.UUID.ViewTitle")
        .actionBar(
            text: "Shared.Generate",
            icon: "sparkles",
            action: regenerate,
            disabled: .constant(false),
            copyValue: .constant(generatedUUID)
        )
    }

    func regenerate() {
        animateChange {
            generatedUUID = UUID().uuidString
        }
    }
}
