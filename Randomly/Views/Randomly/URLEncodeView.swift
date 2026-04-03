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

    var body: some View {
        PasteToolView(
            placeholder: "Developer.URLEncode.Placeholder",
            inputText: $inputText,
            result: $result
        )
        .randomlyNavigation(title: "Developer.URLEncode.ViewTitle")
        .actionBar(
            text: "Developer.Encode",
            icon: "link",
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
            result = inputText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? inputText
        }
    }
}
