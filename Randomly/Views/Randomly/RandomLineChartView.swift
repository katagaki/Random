//
//  RandomLineChartView.swift
//  Random
//
//  Created by Claude on 2026/04/01.
//

import SwiftUI
import Charts

struct RandomLineChartView: View {

    @State var dataPoints: [ChartDataPoint] = []
    @State var pointCount: Float = 8

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            Chart(dataPoints) { point in
                LineMark(
                    x: .value("Chart.Index", point.label),
                    y: .value("Chart.Value", point.value)
                )
                .interpolationMethod(.catmullRom)
                PointMark(
                    x: .value("Chart.Index", point.label),
                    y: .value("Chart.Value", point.value)
                )
            }
            .foregroundStyle(.blue)
            .frame(height: 250)
            .padding()
            Spacer()
            VStack(alignment: .center, spacing: 0.0) {
                Divider()
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("Chart.PointCount.\(String(Int(pointCount)))")
                    Slider(value: $pointCount, in: 3...20, step: 1)
                }
                .padding()
            }
        }
        .task {
            regenerate()
        }
        .randomlyNavigation(title: "Chart.Line.ViewTitle")
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
            dataPoints = (0..<Int(pointCount)).map { index in
                ChartDataPoint(
                    label: "\(index + 1)",
                    value: Double.random(in: 0...100),
                    color: .blue
                )
            }
        }
    }
}
