//
//  ActionBar.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/28.
//

import SwiftUI

struct ActionBar: View {

    @State var primaryActionText: LocalizedStringKey
    @State var primaryActionIconName: String
    @Binding var copyDisabled: Bool
    @State var copyHidden: Bool = false
    @Binding var primaryActionDisabled: Bool
    var primaryAction: () -> Void
    var copyAction: (() -> Void)?

    var body: some View {
        HStack(alignment: .center, spacing: 8.0) {
            copyButton()
            primaryActionButton()
        }
    }

    @ViewBuilder
    func copyButton() -> some View {
        if !copyHidden {
            Button {
                if let copyAction = copyAction {
                    copyAction()
                }
            } label: {
                Label(.sharedCopy, systemImage: "doc.on.doc")
                    .padding(.horizontal, 4.0)
                    .frame(minHeight: 42.0)
            }
            .buttonStyle(.bordered)
            .clipShape(RoundedRectangle(cornerRadius: 99))
            .disabled(copyDisabled)
        }
    }

    @ViewBuilder
    func primaryActionButton() -> some View {
        Button {
            primaryAction()
        } label: {
            Label(primaryActionText, systemImage: primaryActionIconName)
                .bold()
                .padding(.horizontal, 4.0)
                .frame(maxWidth: .infinity, minHeight: 42.0)
        }
        .buttonStyle(.borderedProminent)
        .clipShape(RoundedRectangle(cornerRadius: 99))
        .disabled(primaryActionDisabled)
    }

    @ViewBuilder
    func secondaryAction<Content>(_ secondaryActionButton: @escaping () -> Content) -> some View where Content: View {
        HStack(alignment: .center, spacing: 8.0) {
            copyButton()
            secondaryActionButton()
            primaryActionButton()
        }
    }
}
