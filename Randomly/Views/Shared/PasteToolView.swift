//
//  PasteToolView.swift
//  Random
//
//  Created by Claude on 2026/04/02.
//

import SwiftUI

struct PasteToolView<Controls: View>: View {

    let placeholder: LocalizedStringKey
    @Binding var result: String
    var errorMessage: String?
    let onPaste: (String) -> Void
    let onClear: () -> Void
    @ViewBuilder var controls: () -> Controls

    var body: some View {
        VStack(alignment: .center, spacing: 0.0) {
            if !result.isEmpty {
                ScrollView {
                    Text(result)
                        .font(.system(.body, design: .monospaced))
                        .textSelection(.enabled)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
            } else if let errorMessage {
                Spacer()
                Text(errorMessage)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .padding()
                Spacer()
            } else {
                Spacer()
                Text(placeholder)
                    .font(.body)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            Divider()
            VStack(alignment: .leading, spacing: 8.0) {
                controls()
                HStack(spacing: 8.0) {
                    Button {
                        if let string = UIPasteboard.general.string {
                            onPaste(string)
                        }
                    } label: {
                        Label("Shared.Paste", systemImage: "doc.on.clipboard")
                            .bold()
                    }
                    .prominentPillButton()
                    Button {
                        onClear()
                    } label: {
                        Label("Shared.Clear", systemImage: "xmark")
                            .bold()
                    }
                    .pillButton()
                }
            }
            .padding()
        }
    }
}

extension PasteToolView where Controls == EmptyView {
    init(
        placeholder: LocalizedStringKey,
        result: Binding<String>,
        errorMessage: String? = nil,
        onPaste: @escaping (String) -> Void,
        onClear: @escaping () -> Void
    ) {
        self.placeholder = placeholder
        self._result = result
        self.errorMessage = errorMessage
        self.onPaste = onPaste
        self.onClear = onClear
        self.controls = { EmptyView() }
    }
}
