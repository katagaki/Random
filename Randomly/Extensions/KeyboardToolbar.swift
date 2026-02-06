//
//  KeyboardToolbar.swift
//  Randomly
//
//  Created by シンジャスティン on 2026/02/05.
//

import SwiftUI

/// A view modifier that adds a keyboard toolbar with a "Done" button to dismiss the keyboard
struct KeyboardToolbar: ViewModifier {
    @FocusState.Binding var isFocused: Bool

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Spacer()
                    Button("Shared.Done") {
                        isFocused = false
                    }
                    .bold()
                }
            }
    }
}

/// A view modifier that adds a keyboard toolbar with a "Done" button for optional FocusState
struct KeyboardToolbarOptional<Value: Hashable>: ViewModifier {
    @FocusState.Binding var focusedField: Value?

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Shared.Done") {
                        focusedField = nil
                    }
                    .bold()
                }
            }
    }
}

extension View {
    /// Adds a keyboard toolbar with a "Done" button that dismisses the keyboard
    /// - Parameter isFocused: A binding to a FocusState Bool variable
    /// - Returns: A view with the keyboard toolbar applied
    func keyboardToolbar(isFocused: FocusState<Bool>.Binding) -> some View {
        self.modifier(KeyboardToolbar(isFocused: isFocused))
    }

    /// Adds a keyboard toolbar with a "Done" button that dismisses the keyboard
    /// - Parameter focusedField: A binding to an optional FocusState variable
    /// - Returns: A view with the keyboard toolbar applied
    func keyboardToolbar<Value: Hashable>(focusedField: FocusState<Value?>.Binding) -> some View {
        self.modifier(KeyboardToolbarOptional(focusedField: focusedField))
    }
}
