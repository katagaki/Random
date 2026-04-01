//
//  RandomScatterChartView.swift
//  Random
//
//  Created by Claude on 2026/04/01.
//

import SwiftUI
import Charts

struct ScatterDataPoint: Identifiable {
    let id = UUID()
    let x: Double
    let y: Double
}

struct RandomScatterChartView: View {

    @State var dataPoints: [ScatterDataPoint] = []
    @State var pointCount: Float = 15

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            Chart(dataPoints) { point in
                PointMark(
                    x: .value("Chart.X", point.x),
                    y: .value("Chart.Y", point.y)
                )
                .symbolSize(50)
            }
            .foregroundStyle(.purple)
            .frame(height: 250)
            .padding()
            Spacer()
            VStack(alignment: .center, spacing: 0.0) {
                Divider()
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("Chart.PointCount.\(String(Int(pointCount)))")
                    Slider(value: $pointCount, in: 5...50, step: 1)
                }
                .padding()
            }
        }
        .task {
            regenerate()
        }
        .randomlyNavigation(title: "Chart.Scatter.ViewTitle")
        .actionBar(
            text: "Shared.Generate",
            icon: "sparkles",
            action: regenerate,
            disabled: .constant(false),
            copyValue: .constant(dataPoints.map { "(\(String(format: "%.1f", $0.x)), \(String(format: "%.1f", $0.y)))" }.joined(separator: ", "))
        )
    }

    func regenerate() {
        animateChange {
            dataPoints = (0..<Int(pointCount)).map { _ in
                ScatterDataPoint(
                    x: Double.random(in: 0...100),
                    y: Double.random(in: 0...100)
                )
            }
        }
    }
}
