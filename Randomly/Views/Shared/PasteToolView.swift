//
//  PasteToolView.swift
//  Random
//
//  Created by Claude on 2026/04/02.
//

import SwiftUI

struct PasteToolView<Controls: View>: View {

    let placeholder: LocalizedStringKey
    @Binding var inputText: String
    @Binding var result: String
    var errorMessage: String?
    @ViewBuilder var controls: () -> Controls

    var body: some View {
        VStack(alignment: .center, spacing: 0.0) {
            PlainTextEditor(text: $inputText, placeholder: placeholder)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            if !result.isEmpty || errorMessage != nil {
                Divider()
                if let errorMessage {
                    Text(errorMessage)
                        .font(.system(.body, design: .monospaced))
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                } else {
                    ScrollView {
                        Text(result)
                            .font(.system(.body, design: .monospaced))
                            .textSelection(.enabled)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    }
                    .frame(maxHeight: .infinity)
                }
            }
            controls()
        }
    }
}

struct PlainTextEditor: UIViewRepresentable {

    @Binding var text: String
    var placeholder: LocalizedStringKey

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.font = UIFont.monospacedSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize,
                                                     weight: .regular)
        textView.smartQuotesType = .no
        textView.smartDashesType = .no
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        textView.keyboardType = .asciiCapable
        textView.backgroundColor = .clear
        textView.delegate = context.coordinator
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)

        let placeholderLabel = UILabel()
        placeholderLabel.text = NSLocalizedString(
            placeholder.stringKey ?? "", comment: ""
        )
        placeholderLabel.font = textView.font
        placeholderLabel.textColor = .tertiaryLabel
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.tag = 1
        textView.addSubview(placeholderLabel)
        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 8),
            placeholderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 5)
        ])
        placeholderLabel.isHidden = !text.isEmpty

        return textView
    }

    func updateUIView(_ textView: UITextView, context: Context) {
        if textView.text != text {
            textView.text = text
        }
        if let placeholderLabel = textView.viewWithTag(1) as? UILabel {
            placeholderLabel.isHidden = !text.isEmpty
        }
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: PlainTextEditor

        init(_ parent: PlainTextEditor) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            if let placeholderLabel = textView.viewWithTag(1) as? UILabel {
                placeholderLabel.isHidden = !textView.text.isEmpty
            }
        }
    }
}

extension LocalizedStringKey {
    var stringKey: String? {
        Mirror(reflecting: self).children.first(where: { $0.label == "key" })?.value as? String
    }
}

extension PasteToolView where Controls == EmptyView {
    init(
        placeholder: LocalizedStringKey,
        inputText: Binding<String>,
        result: Binding<String>,
        errorMessage: String? = nil
    ) {
        self.placeholder = placeholder
        self._inputText = inputText
        self._result = result
        self.errorMessage = errorMessage
        self.controls = { EmptyView() }
    }
}
