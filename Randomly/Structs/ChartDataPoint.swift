//
//  ChartDataPoint.swift
//  Random
//
//  Created by Claude on 2026/04/01.
//

import SwiftUI

struct ChartDataPoint: Identifiable {
    let id = UUID()
    let label: String
    let value: Double
    let color: Color

    static let chartColors: [Color] = [
        .blue, .red, .green, .orange, .purple,
        .pink, .yellow, .cyan, .mint, .indigo,
        .brown, .teal
    ]
}
