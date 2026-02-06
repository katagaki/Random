//
//  GenerateCountryView.swift
//  Random
//
//  Created by シンジャスティン on 2026/02/05.
//

import SwiftUI

struct GenerateCountryView: View {
    
    @State var selectedCountry: Country?
    
    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            Spacer()
            if let country = selectedCountry {
                VStack(spacing: 24.0) {
                    Text(country.name)
                        .font(.system(size: 60.0, weight: .heavy, design: .rounded))
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                        .textSelection(.enabled)
                        .multilineTextAlignment(.center)
                        .transition(.scale.combined(with: .opacity))
                        .id(country.id)
                    
                    VStack(spacing: 12.0) {
                        InfoRow(label: "Randomly.Generate.Country.ISOCode", value: country.isoCode)
                        InfoRow(label: "Randomly.Generate.Country.CountryCode", value: country.countryCode)
                        InfoRow(label: "Randomly.Generate.Country.TimeZone", value: country.timeZone)
                    }
                    .font(.system(size: 18.0, design: .rounded))
                    .padding(.horizontal)
                }
                .padding()
            } else {
                Text("Randomly.Generate.Country.Placeholder")
                    .font(.system(size: 40.0, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            Spacer()
            Divider()
            ActionBar(primaryActionText: "Shared.Generate",
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
            .padding([.leading, .trailing])
            .padding(.top, 8.0)
            .padding(.bottom, 16.0)
        }
        .navigationTitle("Randomly.Generate.Country.ViewTitle")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func regenerate() {
        withAnimation(.default.speed(2)) {
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
