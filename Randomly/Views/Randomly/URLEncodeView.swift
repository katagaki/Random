//
//  URLEncodeView.swift
//  Random
//
//  Created by Claude on 2026/04/02.
//

import SwiftUI

struct URLEncodeView: View {

    @State var inputText: String = ""
    @State var result: String = ""
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
            } else {
                Spacer()
                Text("Developer.URLEncode.Placeholder")
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
                            encode()
                        }
                    } label: {
                        Label("Shared.Paste", systemImage: "doc.on.clipboard")
                            .bold()
                    }
                    .prominentPillButton()
                    Button {
                        inputText = ""
                        result = ""
                    } label: {
                        Label("Shared.Clear", systemImage: "xmark")
                            .bold()
                    }
                    .pillButton()
                }
            }
            .padding()
        }
        .randomlyNavigation(title: "Developer.URLEncode.ViewTitle")
        .actionBar(
            text: "Developer.Encode",
            icon: "link",
            action: encode,
            disabled: .constant(inputText.isEmpty),
            copyValue: .constant(result),
            copyDisabled: .constant(result.isEmpty)
        )
    }

    func encode() {
        animateChange {
            result = inputText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? inputText
        }
    }
}
