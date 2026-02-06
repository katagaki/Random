//
//  CountriesView.swift
//  Randomly
//
//  Created by シン・ジャスティン on 2026/02/06.
//

import SwiftUI

struct CountriesView: View {

    @State var countries: [Country] = Country.allCountries
    @State var searchTerm: String = ""
    @State var searchResults: [Country] = []

    var body: some View {
        List {
            if searchTerm.trimmingCharacters(in: .whitespaces) == "" {
                ForEach(countries, id: \.id) { country in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(country.name)
                            .font(.body)
                        HStack(spacing: 8) {
                            Text(country.isoCode)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Text(country.countryCode)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Text(country.timeZone)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .textSelection(.enabled)
                }
            } else {
                ForEach(searchResults, id: \.id) { country in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(country.name)
                            .font(.body)
                        HStack(spacing: 8) {
                            Text(country.isoCode)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Text(country.countryCode)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Text(country.timeZone)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .textSelection(.enabled)
                }
            }
        }
        .navigationTitle("Dataset.Countries")
        .listStyle(.plain)
        .searchable(text: $searchTerm)
        .onChange(of: searchTerm) { _, newValue in
            if newValue.trimmingCharacters(in: .whitespaces) == "" {
                searchResults = countries
            } else {
                searchResults = countries.filter { country in
                    country.name.lowercased().contains(newValue.lowercased()) ||
                    country.isoCode.lowercased().contains(newValue.lowercased()) ||
                    country.countryCode.lowercased().contains(newValue.lowercased())
                }
            }
        }
    }
}
