//
//  PickTimeView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/29.
//

import SwiftUI

struct PickTimeView: View {

    @State var generatedTime: Date = Date()
    @FocusState var isTextFieldActive: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            LargeDisplayTextView(formattedTime())
            Spacer()
        }
        .task {
            regenerate()
        }
        .randomlyNavigation(title: "Generate.Time.ViewTitle")
        .actionBar(
            text: "Shared.Pick",
            icon: "sparkles",
            action: regenerate,
            disabled: .constant(false),
            copyValue: .constant(formattedTime())
        )
    }

    func regenerate() {
        animateChange {
            // Generate random hour (0-23) and minute (0-59)
            let randomHour = Int.random(in: 0...23)
            let randomMinute = Int.random(in: 0...59)

            // Create a calendar and get today's date components
            let calendar = Calendar.current
            var components = calendar.dateComponents([.year, .month, .day], from: Date())
            components.hour = randomHour
            components.minute = randomMinute
            components.second = 0

            generatedTime = calendar.date(from: components) ?? Date()
        }
    }

    func formattedTime() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: generatedTime)
    }
}
