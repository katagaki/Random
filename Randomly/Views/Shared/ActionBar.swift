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
                Image(systemName: "doc.on.doc")
                    .padding(.horizontal, 4.0)
                    .frame(width: 42.0, height: 42.0, alignment: .center)
            }
            .accessibilityLabel(Text(.sharedCopy))
            .buttonStyle(.bordered)
            .clipShape(Circle())
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

struct ActionBarModifier: ViewModifier {
    var text: String
    var icon: String
    var action: (() -> Void)
    @Binding var disabled: Bool

    var copyValue: Binding<Any>?
    @State var copyHidden: Bool = false
    var copyDisabled: Binding<Bool>?

    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            content
                .toolbar {
                    if !copyHidden, copyValue != nil {
                        ToolbarItem(placement: .bottomBar) {
                            Button(action: copy) {
                                Label(.sharedCopy, systemImage: "doc.on.doc")
                            }
                            .disabled(copyDisabled?.wrappedValue ?? false)
                        }
                    }
                    ToolbarSpacer(.flexible, placement: .bottomBar)
                    ToolbarItem(placement: .bottomBar) {
                        Button(
                            LocalizedStringKey(text),
                            systemImage: icon,
                            action: action
                        )
                        .buttonStyle(.glassProminent)
                        .disabled(disabled)
                    }
                }
        } else {
            content
                .safeAreaInset(edge: .bottom, spacing: 0.0) {
                    HStack(alignment: .center, spacing: 8.0) {
                        if !copyHidden, copyValue != nil {
                            Button(action: copy) {
                                Image(systemName: "doc.on.doc")
                                    .padding(.horizontal, 4.0)
                                    .frame(width: 42.0, height: 42.0, alignment: .center)
                            }
                            .accessibilityLabel(Text(.sharedCopy))
                            .buttonStyle(.bordered)
                            .clipShape(Circle())
                            .disabled(copyDisabled?.wrappedValue ?? false)
                        }
                        Button(action: action) {
                            Label(LocalizedStringKey(text), systemImage: icon)
                                .bold()
                                .padding(.horizontal, 4.0)
                                .frame(maxWidth: .infinity, minHeight: 42.0)
                        }
                        .buttonStyle(.borderedProminent)
                        .clipShape(RoundedRectangle(cornerRadius: 99))
                        .disabled(disabled)
                    }
                    .bottomBarBackground()
                }
        }
    }

    func copy() {
        if let copyValue = copyValue {
            UIPasteboard.general.string = "\(copyValue.wrappedValue)"
        }
    }
}

extension View {
    /// Adds an action bar to the view
    func actionBar(
        text: String,
        icon: String,
        action: @escaping () -> Void,
        disabled: Binding<Bool>,
        copyValue: Binding<Any>? = nil,
        copyHidden: Bool = false,
        copyDisabled: Binding<Bool>? = .constant(false)
    ) -> some View {
        modifier(
            ActionBarModifier(
                text: text,
                icon: icon,
                action: action,
                disabled: disabled,
                copyValue: copyValue,
                copyHidden: copyHidden,
                copyDisabled: copyDisabled
            )
        )
    }
}
