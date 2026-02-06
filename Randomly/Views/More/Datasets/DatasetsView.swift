//
//  DatasetsView.swift
//  Randomly
//
//  Created by シン・ジャスティン on 2024/02/10.
//

import SwiftUI

struct DatasetsView: View {

    let wordlists: [Dataset] = [
        Dataset(name: "Dataset.Wordlist", fileName: "Wordlist-EN", fileExtension: "txt"),
        Dataset(name: "Dataset.Tangolist", fileName: "Wordlist-JP", fileExtension: "txt")
    ]

    var body: some View {
        List {
            Section {
                ForEach(wordlists, id: \.name) { wordlistDataset in
                    NavigationLink {
                        DatasetView(dataset: wordlistDataset)
                    } label: {
                        Text(NSLocalizedString(wordlistDataset.name, comment: ""))
                    }
                }
            } header: {
                ListSectionHeader(text: "Dataset.Type.Wordlists")
                    .font(.body)
            }

            Section {
                NavigationLink {
                    CountriesView()
                } label: {
                    Text(NSLocalizedString("Dataset.Countries", comment: ""))
                }
            } header: {
                ListSectionHeader(text: "Dataset.Type.Countries")
                    .font(.body)
            }
        }
        .navigationTitle("More.Datasets.ViewTitle")
        .listStyle(.insetGrouped)
    }
}
