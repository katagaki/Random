//
//  CountUpView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/26.
//

import SwiftUI

struct CountUpView: View {

    @State var useRange: Bool = false
    @State var rangeStart: Int = 1
    @State var rangeEnd: Int = 10
    @State var incrementValue: Int = 1
    @State var startingValue: Int = 0
    @State var currentValue: Int = 0
    @State var hasStarted: Bool = false
    @FocusState var isTextFieldActive: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            LargeDisplayTextView(String(currentValue), fontSize: 200, transitionDirection: .flipUp)
            Spacer()

            if !hasStarted {
                Divider()
                VStack(alignment: .leading, spacing: 16.0) {
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text("Count.StartingValue")
                            .font(.body)
                            .bold()
                        TextField("", value: $startingValue, format: .number)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                            .focused($isTextFieldActive)
                    }

                    Toggle(isOn: $useRange) {
                        Text("Count.UseRandomRange")
                            .font(.body)
                            .bold()
                    }

                    if useRange {
                        RangeInputView(label: "Count.IncrementRange", rangeStart: $rangeStart, rangeEnd: $rangeEnd)
                    } else {
                        VStack(alignment: .leading, spacing: 8.0) {
                            Text("Count.IncrementValue")
                                .font(.body)
                                .bold()
                            TextField("", value: $incrementValue, format: .number)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
                                .focused($isTextFieldActive)
                        }
                    }
                }
                .padding()
                Divider()
            } else {
                Divider()
            }

            if !hasStarted {
                ActionBar(primaryActionText: "Count.Start",
                          primaryActionIconName: "play.fill",
                          copyDisabled: .constant(true),
                          copyHidden: true,
                          primaryActionDisabled: .constant(useRange && rangeEnd <= rangeStart)) {
                    start()
                } copyAction: {
                    // Copy not available before starting
                }
                .frame(maxWidth: .infinity)
                .horizontalPadding()
                .padding(.top, 8.0)
                .padding(.bottom, 16.0)
            } else {
                ActionBar(primaryActionText: "Count.Increment",
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
                    .pillButton()
                }
                .frame(maxWidth: .infinity)
                .horizontalPadding()
                .padding(.top, 8.0)
                .padding(.bottom, 16.0)
            }
        }
        .randomlyNavigation(title: "Count.Up")
    }

    func start() {
        animateChange {
            currentValue = startingValue
            hasStarted = true
        }
    }

    func reset() {
        animateChange {
            startingValue = currentValue
            hasStarted = false
        }
    }

    func increment() {
        animateChange {
            if useRange {
                let randomIncrement = Int.random(in: rangeStart...rangeEnd)
                currentValue += randomIncrement
            } else {
                currentValue += incrementValue
            }
        }
    }
}
