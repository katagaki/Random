//
//  URLDecodeView.swift
//  Random
//
//  Created by Claude on 2026/04/02.
//

import SwiftUI

struct URLDecodeView: View {

    @State var inputText: String = ""
    @State var result: String = ""

    var body: some View {
        PasteToolView(
            placeholder: "Developer.URLDecode.Placeholder",
            result: $result,
            onPaste: { inputText = $0; decode() },
            onClear: { inputText = ""; result = "" }
        )
        .randomlyNavigation(title: "Developer.URLDecode.ViewTitle")
        .actionBar(
            text: "Developer.Decode",
            icon: "link",
            action: decode,
            disabled: .constant(inputText.isEmpty),
            copyValue: .constant(result),
            copyDisabled: .constant(result.isEmpty)
        )
    }

    func decode() {
        animateChange {
            result = inputText.removingPercentEncoding ?? inputText
        }
    }
}
