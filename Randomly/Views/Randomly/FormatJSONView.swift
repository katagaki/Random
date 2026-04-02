//
//  FormatJSONView.swift
//  Random
//
//  Created by Claude on 2026/04/02.
//

import SwiftUI

struct FormatJSONView: View {

    @State var inputText: String = ""
    @State var result: String = ""
    @State var indentSize: Int = 2
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
                Text("Developer.FormatJSON.Placeholder")
                    .font(.body)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            Divider()
            VStack(alignment: .leading, spacing: 8.0) {
                Picker("Developer.FormatJSON.Indent", selection: $indentSize) {
                    Text("Developer.FormatJSON.Indent.2").tag(2)
                    Text("Developer.FormatJSON.Indent.4").tag(4)
                }
                .pickerStyle(.segmented)
                HStack(spacing: 8.0) {
                    Button {
                        if let string = UIPasteboard.general.string {
                            inputText = string
                            formatJSON()
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
        .onChange(of: indentSize) {
            if !inputText.isEmpty {
                formatJSON()
            }
        }
        .randomlyNavigation(title: "Developer.FormatJSON.ViewTitle")
        .actionBar(
            text: "Developer.FormatJSON.Action",
            icon: "curlybraces",
            action: formatJSON,
            disabled: .constant(inputText.isEmpty),
            copyValue: .constant(result),
            copyDisabled: .constant(result.isEmpty)
        )
    }

    func formatJSON() {
        errorMessage = nil
        do {
            let data = Data(inputText.utf8)
            let json = try JSONSerialization.jsonObject(with: data)
            let formatted = try JSONSerialization.data(
                withJSONObject: json,
                options: [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
            )
            if var string = String(data: formatted, encoding: .utf8) {
                if indentSize == 4 {
                    string = string.replacingOccurrences(
                        of: "  ", with: "    "
                    )
                }
                animateChange {
                    result = string
                }
            }
        } catch {
            animateChange {
                result = ""
                errorMessage = error.localizedDescription
            }
        }
    }
}
