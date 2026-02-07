//
//  CountView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/26.
//

import SwiftUI

struct CountView: View {

    let mode: CountMode

    @State var useRange: Bool = false
    @State var rangeStart: Int = 1
    @State var rangeEnd: Int = 10
    @State var changeValue: Int = 1
    @State var startingValue: Int
    @State var currentValue: Int = 0
    @State var hasStarted: Bool = false
    @FocusState var isTextFieldActive: Bool

    init(mode: CountMode) {
        self.mode = mode
        self.startingValue = mode == .up ? 0 : 100
    }

    var body: some View {
        if #available(iOS 26.0, *) {
            ios26Body
        } else {
            legacyBody
        }
    }

    @available(iOS 26.0, *)
    var ios26Body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            LargeDisplayTextView(String(currentValue), fontSize: 200, transitionDirection: mode == .up ? .flipUp : .flipDown)
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
                        RangeInputView(label: mode == .up ? "Count.IncrementRange" : "Count.DecrementRange", rangeStart: $rangeStart, rangeEnd: $rangeEnd, isTextFieldActive: $isTextFieldActive)
                    } else {
                        VStack(alignment: .leading, spacing: 8.0) {
                            Text(mode == .up ? "Count.IncrementValue" : "Count.DecrementValue")
                                .font(.body)
                                .bold()
                            TextField("", value: $changeValue, format: .number)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
                                .focused($isTextFieldActive)
                        }
                    }
                    
                    HStack {
                        Spacer()
                        if isTextFieldActive {
                            Button {
                                isTextFieldActive = false
                            } label: {
                                Label("Shared.Done", systemImage: "keyboard.chevron.compact.down")
                                    .labelStyle(.iconOnly)
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                }
                .padding()
            }
        }
        .randomlyNavigation(title: mode == .up ? "Count.Up" : "Count.Down")
        .toolbar {
            if !hasStarted {
                ToolbarSpacer(.flexible, placement: .bottomBar)
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("Count.Start", systemImage: "play.fill") {
                        start()
                    }
                    .buttonStyle(.glassProminent)
                    .disabled(useRange && rangeEnd <= rangeStart)
                }
            } else {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("Shared.Reset", systemImage: "arrow.counterclockwise") {
                        reset()
                    }
                }
                ToolbarSpacer(.flexible, placement: .bottomBar)
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(mode == .up ? "Count.Increment" : "Count.Decrement", systemImage: mode == .up ? "plus" : "minus") {
                        change()
                    }
                    .buttonStyle(.glassProminent)
                }
            }
        }
    }

    var legacyBody: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            LargeDisplayTextView(String(currentValue), fontSize: 200, transitionDirection: mode == .up ? .flipUp : .flipDown)
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
                        RangeInputView(label: mode == .up ? "Count.IncrementRange" : "Count.DecrementRange", rangeStart: $rangeStart, rangeEnd: $rangeEnd, isTextFieldActive: $isTextFieldActive)
                    } else {
                        VStack(alignment: .leading, spacing: 8.0) {
                            Text(mode == .up ? "Count.IncrementValue" : "Count.DecrementValue")
                                .font(.body)
                                .bold()
                            TextField("", value: $changeValue, format: .number)
                                .keyboardType(.numberPad)
                                .textFieldStyle(.roundedBorder)
                                .focused($isTextFieldActive)
                        }
                    }
                    
                    HStack {
                        Spacer()
                        if isTextFieldActive {
                            Button {
                                isTextFieldActive = false
                            } label: {
                                Label("Shared.Done", systemImage: "keyboard.chevron.compact.down")
                                    .labelStyle(.iconOnly)
                            }
                            .buttonStyle(.bordered)
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
                ActionBar(primaryActionText: mode == .up ? "Count.Increment" : "Count.Decrement",
                          primaryActionIconName: mode == .up ? "plus" : "minus",
                          copyDisabled: .constant(true),
                          copyHidden: true,
                          primaryActionDisabled: .constant(false)) {
                    change()
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
        .randomlyNavigation(title: mode == .up ? "Count.Up" : "Count.Down")
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

    func change() {
        animateChange {
            if useRange {
                let randomChange = Int.random(in: rangeStart...rangeEnd)
                if mode == .up {
                    currentValue += randomChange
                } else {
                    currentValue -= randomChange
                }
            } else {
                if mode == .up {
                    currentValue += changeValue
                } else {
                    currentValue -= changeValue
                }
            }
        }
    }
}
