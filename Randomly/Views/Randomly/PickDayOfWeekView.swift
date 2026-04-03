//
//  PickDayOfWeekView.swift
//  Random
//
//  Created by Claude on 2026/04/01.
//

import SwiftUI

struct PickDayOfWeekView: View {

    @State var generatedDay: Int = 1

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            LargeDisplayTextView(formattedDay())
            Spacer()
        }
        .task {
            regenerate()
        }
        .randomlyNavigation(title: "Pick.DayOfWeek.ViewTitle")
        .actionBar(
            text: "Shared.Pick",
            icon: "sparkles",
            action: regenerate,
            disabled: .constant(false),
            copyValue: .constant(formattedDay())
        )
    }

    func regenerate() {
        animateChange {
            generatedDay = Int.random(in: 1...7)
        }
    }

    func formattedDay() -> String {
        let formatter = DateFormatter()
        let symbols = formatter.standaloneWeekdaySymbols ?? []
        guard generatedDay >= 1 && generatedDay <= symbols.count else { return "" }
        return symbols[generatedDay - 1]
    }
}
