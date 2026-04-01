//
//  RandomPieChartView.swift
//  Random
//
//  Created by Claude on 2026/04/01.
//

import SwiftUI
import Charts

struct RandomPieChartView: View {

    @State var dataPoints: [ChartDataPoint] = []
    @State var sliceCount: Float = 5

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            Chart(dataPoints) { point in
                SectorMark(
                    angle: .value("Chart.Value", point.value),
                    innerRadius: .ratio(0.4),
                    angularInset: 1.5
                )
                .foregroundStyle(point.color)
                .annotation(position: .overlay) {
                    Text(point.label)
                        .font(.caption2)
                        .bold()
                        .foregroundStyle(.white)
                }
            }
            .frame(height: 280)
            .padding()
            Spacer()
            VStack(alignment: .center, spacing: 0.0) {
                Divider()
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("Chart.SliceCount.\(String(Int(sliceCount)))")
                    Slider(value: $sliceCount, in: 2...10, step: 1)
                }
                .padding()
            }
        }
        .task {
            regenerate()
        }
        .randomlyNavigation(title: "Chart.Pie.ViewTitle")
        .actionBar(
            text: "Shared.Generate",
            icon: "sparkles",
            action: regenerate,
            disabled: .constant(false),
            copyValue: .constant(dataPoints.map { "\($0.label): \(Int($0.value))%" }.joined(separator: ", "))
        )
    }

    func regenerate() {
        animateChange {
            dataPoints = (0..<Int(sliceCount)).map { index in
                ChartDataPoint(
                    label: String(UnicodeScalar(65 + index)!),
                    value: Double.random(in: 5...50),
                    color: ChartDataPoint.chartColors[index % ChartDataPoint.chartColors.count]
                )
            }
        }
    }
}
