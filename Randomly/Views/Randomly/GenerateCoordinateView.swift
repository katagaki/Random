//
//  GenerateCoordinateView.swift
//  Random
//
//  Created by シンジャスティン on 2026/02/06.
//

import SwiftUI
import MapKit
import CoreLocation

struct GenerateCoordinateView: View {

    @State var latitude: Double = 0.0
    @State var longitude: Double = 0.0
    @State var position: MapCameraPosition = .automatic
    @FocusState var isTextFieldActive: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Map(position: $position) {
                Marker("", coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            }
            .transition(.opacity)
            HStack(alignment: .center, spacing: 8.0) {
                HStack(alignment: .center, spacing: 4.0) {
                    Text("Shared.Latitude")
                        .font(.body)
                        .bold()
                    TextField("", value: $latitude, format: .number)
                }
                HStack(alignment: .center, spacing: 4.0) {
                    Text("Shared.Longitude")
                        .font(.body)
                        .bold()
                    TextField("", value: $longitude, format: .number)
                }
            }
            .textFieldStyle(.roundedBorder)
            .focused($isTextFieldActive)
            .disabled(true)
            .padding()
            Divider()
            ActionBar(primaryActionText: "Shared.Generate",
                      primaryActionIconName: "sparkles",
                      copyDisabled: .constant(false),
                      primaryActionDisabled: .constant(false)) {
                regenerate()
            } copyAction: {
                UIPasteboard.general.string = "\(String(format: "%.6f", latitude)), \(String(format: "%.6f", longitude))"
            }
            .frame(maxWidth: .infinity)
            .padding([.leading, .trailing])
            .padding(.top, 8.0)
            .padding(.bottom, 16.0)
        }
        .task {
            regenerate()
        }
        .navigationTitle("Generate.Coordinate.ViewTitle")
        .navigationBarTitleDisplayMode(.inline)
    }

    func regenerate() {
        withAnimation(.default.speed(2)) {
            let landRegions: [(latRange: ClosedRange<Double>, lonRange: ClosedRange<Double>)] = [
                // North America
                (15...72, -168...(-52)),
                // South America
                (-56...13, -82...(-34)),
                // Europe
                (36...71, -10...40),
                // Africa
                (-35...37, -18...52),
                // Asia
                (-10...77, 26...180),
                // Australia/Oceania
                (-47...(-10), 113...180),
                // Additional Asia/Russia
                (40...77, -180...(-130))
            ]

            if Double.random(in: 0...1) < 0.8 {
                let region = landRegions.randomElement()!
                latitude = Double.random(in: region.latRange)
                longitude = Double.random(in: region.lonRange)
            } else {
                latitude = Double.random(in: -90...90)
                longitude = Double.random(in: -180...180)
            }

            position = .camera(MapCamera(
                centerCoordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                distance: 10000000
            ))
        }
    }
}
