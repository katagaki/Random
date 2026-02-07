//
//  PickDateView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/29.
//

import SwiftUI

struct PickDateView: View {

    @State var generatedDate: Date = Date()
    @State var startDate: Date = Date(timeIntervalSince1970: 885686400)
    @State var endDate: Date = Date()
    @FocusState var isTextFieldActive: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            LargeDisplayTextView(formattedDate())
            Spacer()
            VStack(alignment: .center, spacing: 0.0) {
                Divider()
                VStack(alignment: .leading, spacing: 8.0) {
                    HStack(alignment: .center, spacing: 4.0) {
                        Text("Shared.RangeFrom")
                            .font(.body)
                            .bold()
                        DatePicker("", selection: $startDate, displayedComponents: [.date])
                            .labelsHidden()
                        Text("Shared.RangeTo")
                            .font(.body)
                            .bold()
                        DatePicker("", selection: $endDate, displayedComponents: [.date])
                            .labelsHidden()
                        Spacer(minLength: 0.0)
                    }
                }
                .padding()
            }
        }
        .task {
            regenerate()
        }
        .randomlyNavigation(title: "Generate.Date.ViewTitle")
        .actionBar(
            text: "Shared.Pick",
            icon: "sparkles",
            action: regenerate,
            disabled: .constant(endDate <= startDate),
            copyValue: .constant(formattedDate())
        )
    }

    func regenerate() {
        animateChange {
            let startInterval = startDate.timeIntervalSince1970
            let endInterval = endDate.timeIntervalSince1970
            let randomInterval = TimeInterval.random(in: startInterval...endInterval)
            generatedDate = Date(timeIntervalSince1970: randomInterval)
        }
    }

    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: generatedDate)
    }
}
