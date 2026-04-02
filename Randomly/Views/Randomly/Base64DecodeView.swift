//
//  Base64DecodeView.swift
//  Random
//
//  Created by Claude on 2026/04/02.
//

import SwiftUI

struct Base64DecodeView: View {

    @State var inputText: String = ""
    @State var result: String = ""
    @State var errorMessage: String?
    @FocusState var isTextFieldActive: Bool

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
                Text("Developer.Base64Decode.Placeholder")
                    .font(.body)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            Divider()
            VStack(alignment: .leading, spacing: 8.0) {
                HStack(spacing: 8.0) {
                    Button {
                        if let string = UIPasteboard.general.string {
                            inputText = string
                            decode()
                        }
                    } label: {
                        Label("Shared.Paste", systemImage: "doc.on.clipboard")
                            .bold()
                    }
                    .prominentPillButton()
                    Button {
                        inputText = ""
                        result = ""
                        errorMessage = nil
                    } label: {
                        Label("Shared.Clear", systemImage: "xmark")
                            .bold()
                    }
                    .pillButton()
                }
            }
            .padding()
        }
        .randomlyNavigation(title: "Developer.Base64Decode.ViewTitle")
        .actionBar(
            text: "Developer.Decode",
            icon: "lock.open",
            action: decode,
            disabled: .constant(inputText.isEmpty),
            copyValue: .constant(result),
            copyDisabled: .constant(result.isEmpty)
        )
    }

    func decode() {
        errorMessage = nil
        animateChange {
            if let data = Data(base64Encoded: inputText),
               let decoded = String(data: data, encoding: .utf8) {
                result = decoded
            } else {
                result = ""
                errorMessage = NSLocalizedString("Developer.Base64Decode.Error", comment: "")
            }
        }
    }
}
