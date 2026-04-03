//
//  PickMonthView.swift
//  Random
//
//  Created by Claude on 2026/04/01.
//

import SwiftUI

struct PickMonthView: View {

    @State var generatedMonth: Int = 1

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            LargeDisplayTextView(formattedMonth())
            Spacer()
        }
        .task {
            regenerate()
        }
        .randomlyNavigation(title: "Pick.Month.ViewTitle")
        .actionBar(
            text: "Shared.Pick",
            icon: "sparkles",
            action: regenerate,
            disabled: .constant(false),
            copyValue: .constant(formattedMonth())
        )
    }

    func regenerate() {
        animateChange {
            generatedMonth = Int.random(in: 1...12)
        }
    }

    func formattedMonth() -> String {
        let formatter = DateFormatter()
        let symbols = formatter.standaloneMonthSymbols ?? []
        guard generatedMonth >= 1 && generatedMonth <= symbols.count else { return "" }
        return symbols[generatedMonth - 1]
    }
}
