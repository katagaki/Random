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
            Text(formattedDate())
                .font(.system(size: 120.0, weight: .heavy, design: .rounded))
                .lineLimit(1)
                .minimumScaleFactor(0.01)
                .textSelection(.enabled)
                .padding()
                .transition(.scale.combined(with: .opacity))
                .id(generatedDate)
            Spacer()
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
            Divider()
            ActionBar(primaryActionText: "Shared.Pick",
                      primaryActionIconName: "sparkles",
                      copyDisabled: .constant(false),
                      primaryActionDisabled: .constant(endDate <= startDate)) {
                regenerate()
            } copyAction: {
                UIPasteboard.general.string = formattedDate()
            }
            .frame(maxWidth: .infinity)
            .padding([.leading, .trailing])
            .padding(.top, 8.0)
            .padding(.bottom, 16.0)
        }
        .task {
            regenerate()
        }
        .navigationTitle("Generate.Date.ViewTitle")
        .navigationBarTitleDisplayMode(.inline)
    }

    func regenerate() {
        withAnimation(.default.speed(2)) {
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
