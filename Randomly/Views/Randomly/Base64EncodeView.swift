//
//  Base64EncodeView.swift
//  Random
//
//  Created by Claude on 2026/04/02.
//

import SwiftUI

struct Base64EncodeView: View {

    @State var inputText: String = ""
    @State var result: String = ""

    var body: some View {
        PasteToolView(
            placeholder: "Developer.Base64Encode.Placeholder",
            inputText: $inputText,
            result: $result
        )
        .randomlyNavigation(title: "Developer.Base64Encode.ViewTitle")
        .actionBar(
            text: "Developer.Encode",
            icon: "lock",
            action: encode,
            disabled: .constant(inputText.isEmpty),
            copyValue: .constant(result),
            copyDisabled: .constant(result.isEmpty),
            pasteAction: {
                if let string = UIPasteboard.general.string {
                    inputText = string
                    encode()
                }
            }
        )
    }

    func encode() {
        animateChange {
            result = Data(inputText.utf8).base64EncodedString()
        }
    }
}
