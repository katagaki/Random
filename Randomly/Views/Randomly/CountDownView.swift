//
//  CountDownView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/26.
//

import SwiftUI

struct CountDownView: View {

    @State var useRange: Bool = false
    @State var rangeStart: Int = 1
    @State var rangeEnd: Int = 10
    @State var decrementValue: Int = 1
    @State var startingValue: Int = 100
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

                    Toggle(isOn: $useRange) {
                        Text("Randomly.Count.UseRandomRange")
                            .font(.body)
                            .bold()
                    }

                    if useRange {
                        VStack(alignment: .leading, spacing: 8.0) {
                            Text("Randomly.Count.DecrementRange")
                                .font(.body)
                                .bold()
                            HStack(alignment: .center, spacing: 4.0) {
                                Text("Shared.RangeFrom")
                                    .font(.body)
                                TextField("", value: $rangeStart, format: .number)
                                    .focused($isTextFieldActive)
                                Text("Shared.RangeTo")
                                    .font(.body)
                                TextField("", value: $rangeEnd, format: .number)
                                    .focused($isTextFieldActive)
                            }
                            .textFieldStyle(.roundedBorder)
                        }
                    } else {
                        VStack(alignment: .leading, spacing: 8.0) {
                            Text("Neatly.Count.DecrementValue")
                                .font(.body)
                                .bold()
                            TextField("", value: $decrementValue, format: .number)
                                .textFieldStyle(.roundedBorder)
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
                ActionBar(primaryActionText: "Randomly.Count.Start",
                          primaryActionIconName: "play.fill",
                          copyDisabled: .constant(true),
                          copyHidden: true,
                          primaryActionDisabled: .constant(useRange && rangeEnd <= rangeStart)) {
                    start()
                } copyAction: {
                    // Copy not available before starting
                }
                .frame(maxWidth: .infinity)
                .padding([.leading, .trailing])
                .padding(.top, 8.0)
                .padding(.bottom, 16.0)
            } else {
                ActionBar(primaryActionText: "Randomly.Count.Decrement",
                          primaryActionIconName: "minus",
                          copyDisabled: .constant(true),
                          copyHidden: true,
                          primaryActionDisabled: .constant(false)) {
                    decrement()
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
        .navigationTitle("Randomly.Count.Down")
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

    func decrement() {
        withAnimation(.default.speed(2)) {
            if useRange {
                let randomDecrement = Int.random(in: rangeStart...rangeEnd)
                currentValue -= randomDecrement
            } else {
                currentValue -= decrementValue
            }
        }
    }
}
