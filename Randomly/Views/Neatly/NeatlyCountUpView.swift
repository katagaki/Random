//
//  NeatlyCountUpView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/26.
//

import SwiftUI

struct NeatlyCountUpView: View {

    @State var incrementValue: Int = 1
    @State var startingValue: Int = 0
    @State var currentValue: Int = 0
    @State var hasStarted: Bool = false
    @FocusState var isTextFieldActive: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            Text(String(currentValue))
                .font(.system(size: 200.0, weight: .heavy, design: .rounded))
                .lineLimit(1)
                .minimumScaleFactor(0.01)
                .textSelection(.enabled)
                .padding()
                .transition(.scale.combined(with: .opacity))
                .id(currentValue)
            Spacer()

            if !hasStarted {
                Divider()
                VStack(alignment: .leading, spacing: 16.0) {
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text("Randomly.Count.StartingValue")
                            .font(.body)
                            .bold()
                        TextField("", value: $startingValue, format: .number)
                            .textFieldStyle(.roundedBorder)
                            .focused($isTextFieldActive)
                    }

                    VStack(alignment: .leading, spacing: 8.0) {
                        Text("Neatly.Count.IncrementValue")
                            .font(.body)
                            .bold()
                        TextField("", value: $incrementValue, format: .number)
                            .textFieldStyle(.roundedBorder)
                            .focused($isTextFieldActive)
                    }
                }
                .padding()
                Divider()
            } else {
                Divider()
            }

            if !hasStarted {
                ActionBar(primaryActionText: "Randomly.Count.Start",
                          primaryActionIconName: "play.fill",
                          copyDisabled: .constant(true),
                          copyHidden: true,
                          primaryActionDisabled: .constant(false)) {
                    start()
                } copyAction: {
                    // Copy not available before starting
                }
                .frame(maxWidth: .infinity)
                .padding([.leading, .trailing])
                .padding(.top, 8.0)
                .padding(.bottom, 16.0)
            } else {
                ActionBar(primaryActionText: "Randomly.Count.Increment",
                          primaryActionIconName: "plus",
                          copyDisabled: .constant(true),
                          copyHidden: true,
                          primaryActionDisabled: .constant(false)) {
                    increment()
                } copyAction: {
                    // Copy not available
                }
                .secondaryAction {
                    Button {
                        reset()
                    } label: {
                        Label("Shared.Reset", systemImage: "arrow.counterclockwise")
                            .padding(.horizontal, 4.0)
                            .frame(minHeight: 42.0)
                    }
                    .buttonStyle(.bordered)
                    .clipShape(RoundedRectangle(cornerRadius: 99))
                }
                .frame(maxWidth: .infinity)
                .padding([.leading, .trailing])
                .padding(.top, 8.0)
                .padding(.bottom, 16.0)
            }
        }
        .keyboardToolbar(isFocused: $isTextFieldActive)
        .navigationTitle("Neatly.Count.Up")
        .navigationBarTitleDisplayMode(.inline)
    }

    func start() {
        withAnimation(.default.speed(2)) {
            currentValue = startingValue
            hasStarted = true
        }
    }

    func reset() {
        withAnimation(.default.speed(2)) {
            startingValue = currentValue
            hasStarted = false
        }
    }

    func increment() {
        withAnimation(.default.speed(2)) {
            currentValue += incrementValue
        }
    }
}
