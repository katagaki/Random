//
//  RandomBarChartView.swift
//  Random
//
//  Created by Claude on 2026/04/01.
//

import SwiftUI
import Charts

struct RandomBarChartView: View {

    @State var dataPoints: [ChartDataPoint] = []
    @State var barCount: Float = 6

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            Chart(dataPoints) { point in
                BarMark(
                    x: .value("Chart.Category", point.label),
                    y: .value("Chart.Value", point.value)
                )
                .foregroundStyle(point.color)
            }
            .frame(height: 250)
            .padding()
            Spacer()
            VStack(alignment: .center, spacing: 0.0) {
                Divider()
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("Chart.BarCount.\(String(Int(barCount)))")
                    Slider(value: $barCount, in: 2...12, step: 1)
                }
                .padding()
            }
        }
        .task {
            regenerate()
        }
        .randomlyNavigation(title: "Chart.Bar.ViewTitle")
        .actionBar(
            text: "Shared.Generate",
            icon: "sparkles",
            action: regenerate,
            disabled: .constant(false),
            copyValue: .constant(dataPoints.map { "\($0.label): \($0.value)" }.joined(separator: ", "))
        )
    }

    func regenerate() {
        animateChange {
            dataPoints = (0..<Int(barCount)).map { index in
                ChartDataPoint(
                    label: String(UnicodeScalar(65 + index)!),
                    value: Double.random(in: 1...100),
                    color: ChartDataPoint.chartColors[index % ChartDataPoint.chartColors.count]
                )
            }
        }
    }
}
