//
//  GenerateUUIDv7View.swift
//  Random
//
//  Created by Claude on 2026/04/03.
//

import Foundation
import SwiftUI

struct GenerateUUIDv7View: View {

    @State var generatedUUID: String = ""

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            ScrollView(.horizontal) {
                Text(generatedUUID)
                    .font(.system(size: 30, weight: .heavy, design: .monospaced))
                    .lineLimit(1)
                    .textSelection(.enabled)
                    .padding()
                    .contentTransition(.numericText())
            }
            .scrollIndicators(.hidden)
            Spacer()
        }
        .task {
            regenerate()
        }
        .randomlyNavigation(title: "Generate.UUIDv7.ViewTitle")
        .actionBar(
            text: "Shared.Generate",
            icon: "sparkles",
            action: regenerate,
            disabled: .constant(false),
            copyValue: .constant(generatedUUID)
        )
    }

    func regenerate() {
        animateChange {
            generatedUUID = Self.generateUUIDv7()
        }
    }

    static func generateUUIDv7() -> String {
        var bytes = [UInt8](repeating: 0, count: 16)

        // First 48 bits: Unix timestamp in milliseconds
        let timestamp = UInt64(Date().timeIntervalSince1970 * 1000)
        bytes[0] = UInt8((timestamp >> 40) & 0xFF)
        bytes[1] = UInt8((timestamp >> 32) & 0xFF)
        bytes[2] = UInt8((timestamp >> 24) & 0xFF)
        bytes[3] = UInt8((timestamp >> 16) & 0xFF)
        bytes[4] = UInt8((timestamp >> 8) & 0xFF)
        bytes[5] = UInt8(timestamp & 0xFF)

        // Fill remaining 10 bytes with random data
        for index in 6..<16 {
            bytes[index] = UInt8.random(in: 0...255)
        }

        // Set version to 7 (bits 48-51)
        bytes[6] = (bytes[6] & 0x0F) | 0x70

        // Set variant to RFC 4122 (bits 64-65)
        bytes[8] = (bytes[8] & 0x3F) | 0x80

        // Format as UUID string
        let hex = bytes.map { String(format: "%02x", $0) }.joined()
        let uuid = "\(hex.prefix(8))-\(hex.dropFirst(8).prefix(4))-\(hex.dropFirst(12).prefix(4))-\(hex.dropFirst(16).prefix(4))-\(hex.dropFirst(20))"
        return uuid.uppercased()
    }
}
