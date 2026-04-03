//
//  GenerateNumberSequenceView.swift
//  Random
//
//  Created by Claude on 2026/04/01.
//

import SwiftUI

struct GenerateNumberSequenceView: View {

    @State var numbers: [Int] = []
    @State var count: Float = 5
    @State var minimum: String = "1"
    @State var maximum: String = "100"
    @FocusState var isTextFieldActive: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            ScrollView(.horizontal) {
                Text(numbers.map(String.init).joined(separator: ", "))
                    .font(.system(size: 30, weight: .heavy, design: .monospaced))
                    .lineLimit(1)
                    .textSelection(.enabled)
                    .padding()
                    .contentTransition(.numericText())
            }
            .scrollIndicators(.hidden)
            Spacer()
            VStack(alignment: .center, spacing: 0.0) {
                Divider()
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("Generate.NumberSequence.Count.\(String(Int(count)))")
                    Slider(value: $count, in: 1...20, step: 1)
                    HStack(alignment: .center, spacing: 8.0) {
                        HStack(alignment: .center, spacing: 4.0) {
                            Text("Shared.Min")
                                .font(.body)
                                .bold()
                            TextField("1", text: $minimum)
                                .keyboardType(.numberPad)
                        }
                        HStack(alignment: .center, spacing: 4.0) {
                            Text("Shared.Max")
                                .font(.body)
                                .bold()
                            TextField("100", text: $maximum)
                                .keyboardType(.numberPad)
                        }
                    }
                    .textFieldStyle(.roundedBorder)
                    .focused($isTextFieldActive)
                }
                .padding()
            }
        }
        .task {
            regenerate()
        }
        .randomlyNavigation(title: "Generate.NumberSequence.ViewTitle")
        .actionBar(
            text: "Shared.Generate",
            icon: "sparkles",
            action: regenerate,
            disabled: .constant(parsedMin > parsedMax),
            copyValue: .constant(numbers.map(String.init).joined(separator: ", "))
        )
    }

    var parsedMin: Int {
        Int(minimum) ?? 1
    }

    var parsedMax: Int {
        Int(maximum) ?? 100
    }

    func regenerate() {
        let min = parsedMin
        let max = parsedMax
        guard min <= max else { return }
        animateChange {
            numbers = (0..<Int(count)).map { _ in Int.random(in: min...max) }
        }
    }
}
