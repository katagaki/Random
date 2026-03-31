//
//  ShuffleLettersView.swift
//  Random
//
//  Created by Claude on 2026/03/31.
//

import SwiftUI

struct ShuffleLettersView: View {

    @State var inputText: String = ""
    @State var result: String = ""
    @FocusState var isTextFieldActive: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            LargeDisplayTextView(result, fontSize: 80)
            Spacer()
            VStack(alignment: .center, spacing: 0.0) {
                Divider()
                VStack(alignment: .leading, spacing: 8.0) {
                    TextField("Shuffle.Letters.Placeholder", text: $inputText)
                        .textFieldStyle(.roundedBorder)
                        .submitLabel(.done)
                        .focused($isTextFieldActive)
                        .onSubmit {
                            isTextFieldActive = false
                        }
                    HStack {
                        Spacer()
                        if isTextFieldActive {
                            Button {
                                isTextFieldActive = false
                            } label: {
                                Label("Shared.Done", systemImage: "keyboard.chevron.compact.down")
                                    .labelStyle(.iconOnly)
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
        }
        .randomlyNavigation(title: "Shuffle.Letters.ViewTitle")
        .actionBar(
            text: "Shared.Shuffle",
            icon: "arrow.up.and.down.and.sparkles",
            action: shuffle,
            disabled: .constant(inputText.isEmpty),
            copyValue: .constant(result),
            copyDisabled: .constant(result.isEmpty)
        )
    }

    func shuffle() {
        animateChange {
            result = String(inputText.shuffled())
        }
    }
}
