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

    var body: some View {
        PasteToolView(
            placeholder: "Developer.Base64Decode.Placeholder",
            result: $result,
            errorMessage: errorMessage,
            onPaste: { inputText = $0; decode() },
            onClear: { inputText = ""; result = ""; errorMessage = nil }
        )
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
