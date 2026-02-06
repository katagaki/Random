//
//  SelectTimeView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/29.
//

import SwiftUI

struct SelectTimeView: View {

    @State var generatedTime: Date = Date()
    @FocusState var isTextFieldActive: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            Text(formattedTime())
                .font(.system(size: 120.0, weight: .heavy, design: .rounded))
                .lineLimit(1)
                .minimumScaleFactor(0.01)
                .textSelection(.enabled)
                .padding()
                .transition(.scale.combined(with: .opacity))
                .id(generatedTime)
            Spacer()
            Divider()
            ActionBar(primaryActionText: "Shared.Generate",
                      primaryActionIconName: "sparkles",
                      copyDisabled: .constant(false),
                      primaryActionDisabled: .constant(false)) {
                regenerate()
            } copyAction: {
                UIPasteboard.general.string = formattedTime()
            }
            .frame(maxWidth: .infinity)
            .padding([.leading, .trailing])
            .padding(.top, 8.0)
            .padding(.bottom, 16.0)
        }
        .task {
            regenerate()
        }
        .keyboardToolbar(isFocused: $isTextFieldActive)
        .navigationTitle("Randomly.Generate.Time.ViewTitle")
        .navigationBarTitleDisplayMode(.inline)
    }

    func regenerate() {
        withAnimation(.default.speed(2)) {
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
