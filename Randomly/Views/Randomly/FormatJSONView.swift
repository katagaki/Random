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

    var body: some View {
        PasteToolView(
            placeholder: "Developer.FormatJSON.Placeholder",
            result: $result,
            errorMessage: errorMessage,
            onPaste: { inputText = $0; formatJSON() },
            onClear: { inputText = ""; result = ""; errorMessage = nil }
        ) {
            Picker("Developer.FormatJSON.Indent", selection: $indentSize) {
                Text("Developer.FormatJSON.Indent.2").tag(2)
                Text("Developer.FormatJSON.Indent.4").tag(4)
            }
            .pickerStyle(.segmented)
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
