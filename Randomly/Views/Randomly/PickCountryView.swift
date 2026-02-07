//
//  PickCountryView.swift
//  Random
//
//  Created by シンジャスティン on 2026/02/05.
//

import SwiftUI

struct PickCountryView: View {

    @State var selectedCountry: Country?

    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            if let country = selectedCountry {
                VStack(spacing: 24.0) {
                    Text(country.name)
                        .font(.system(size: 50.0, weight: .heavy, design: .rounded))
                        .lineLimit(1)
                        .minimumScaleFactor(0.01)
                        .textSelection(.enabled)
                        .multilineTextAlignment(.center)
                        .transition(.scale.combined(with: .opacity))
                        .id(country.id)

                    VStack(spacing: 12.0) {
                        InfoRow(label: "Generate.Country.ISOCode", value: country.isoCode)
                        InfoRow(label: "Generate.Country.CountryCode", value: country.countryCode)
                        InfoRow(label: "Generate.Country.TimeZone", value: country.timeZone)
                    }
                    .font(.system(size: 18.0, design: .rounded))
                    .padding(.horizontal)
                }
                .padding()
                .frame(maxWidth: .infinity)
            } else {
                Text("Generate.Country.Placeholder")
                    .font(.system(size: 40.0, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            Spacer()
            Divider()
            ActionBar(primaryActionText: "Shared.Pick",
                      primaryActionIconName: "sparkles",
                      copyDisabled: .constant(selectedCountry == nil),
                      primaryActionDisabled: .constant(false)) {
                regenerate()
            } copyAction: {
                if let country = selectedCountry {
                    let text = """
                    \(country.name)
                    ISO: \(country.isoCode)
                    Country Code: \(country.countryCode)
                    Time Zone: \(country.timeZone)
                    """
                    UIPasteboard.general.string = text
                }
            }
            .frame(maxWidth: .infinity)
            .horizontalPadding()
            .padding(.top, 8.0)
            .padding(.bottom, 16.0)
        }
        .randomlyNavigation(title: "Generate.Country.ViewTitle")
        .task {
            regenerate()
        }
    }

    func regenerate() {
        animateChange {
            selectedCountry = Country.allCountries.randomElement()
        }
    }
}

struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(NSLocalizedString(label, comment: ""))
                .font(.headline)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.body)
                .fontWeight(.semibold)
                .textSelection(.enabled)
        }
        .padding(.horizontal, 16.0)
    }
}
