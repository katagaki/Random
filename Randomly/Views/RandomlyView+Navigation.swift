//
//  RandomlyView+Navigation.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/26.
//

import SwiftUI

extension RandomlyView {

    @ViewBuilder
    // swiftlint:disable:next cyclomatic_complexity function_body_length
    static func destination(for viewPath: ViewPath) -> some View {
        switch viewPath {
        case .pickNumber:
            PickNumberLetterWordView(mode: .number)
        case .pickLetter:
            PickNumberLetterWordView(mode: .letter)
        case .word:
            WordView()
        case .pickEmoji:
            PickEmojiView()
        case .pickDate:
            PickDateView()
        case .pickTime:
            PickTimeView()
        case .pickCountry:
            PickCountryView()
        case .generatePassword:
            GeneratePasswordView()
        case .generateColor:
            GenerateColorView()
        case .generateCoordinate:
            GenerateCoordinateView()
        case .generateLoremIpsum:
            GenerateLoremIpsumView()
        case .selectItemFromList:
            SelectItemFromListView()
        case .selectWordFromText:
            SelectWordFromTextView()
        case .selectGroupFromList:
            SelectGroupFromListView()
        case .shuffleList:
            SortShuffleListView(mode: .shuffle)
        case .shuffleDict:
            SortShuffleDictionaryView(mode: .shuffle)
        case .shuffleLetters:
            ShuffleLettersView()
        case .sortList:
            SortShuffleListView(mode: .sort)
        case .sortDict:
            SortShuffleDictionaryView(mode: .sort)
        case .groupList:
            GroupListView()
        case .groupDict:
            GroupDictionaryView()
        case .countUp:
            CountView(mode: .up)
        case .countDown:
            CountView(mode: .down)
        case .tossCoin:
            TossCoinView()
        case .rollDice:
            RollDiceView()
        case .drawCard:
            DrawCardView()
        case .pickDayOfWeek:
            PickDayOfWeekView()
        case .pickMonth:
            PickMonthView()
        case .generateUUIDv4:
            GenerateUUIDv4View()
        case .generateUUIDv7:
            GenerateUUIDv7View()
        case .generateNumberSequence:
            GenerateNumberSequenceView()
        case .generatePassphrase:
            GeneratePassphraseView()
        case .chartBar:
            RandomBarChartView()
        case .chartPie:
            RandomPieChartView()
        case .chartLine:
            RandomLineChartView()
        case .chartScatter:
            RandomScatterChartView()
        case .formatJSON:
            FormatJSONView()
        case .base64Encode:
            Base64EncodeView()
        case .base64Decode:
            Base64DecodeView()
        case .urlEncode:
            URLEncodeView()
        case .urlDecode:
            URLDecodeView()
        default:
            Color.clear
        }
    }

    var moreSheet: some View {
        NavigationStack {
            MoreList(repoName: "katagaki/Random", viewPath: ViewPath.moreAttributions) {
                Section {
                    NavigationLink(value: ViewPath.moreWordlistEnglish) {
                        Text(NSLocalizedString("Dataset.Wordlist", comment: ""))
                    }
                    NavigationLink(value: ViewPath.moreWordlistJapanese) {
                        Text(NSLocalizedString("Dataset.Tangolist", comment: ""))
                    }
                } header: {
                    ListSectionHeader(text: "Dataset.Type.Wordlists")
                        .font(.body)
                }
                Section {
                    NavigationLink(value: ViewPath.moreCountries) {
                        Text(NSLocalizedString("Dataset.Countries", comment: ""))
                    }
                } header: {
                    ListSectionHeader(text: "Dataset.Type.Countries")
                        .font(.body)
                }
            }
            .navigationDestination(
                for: ViewPath.self,
                destination: { viewPath in
                    switch viewPath {
                    case .moreWordlistEnglish:
                        DatasetView(
                            dataset: Dataset(
                                name: "Dataset.Wordlist",
                                fileName: "Wordlist-EN",
                                fileExtension: "txt"
                            )
                        )
                    case .moreWordlistJapanese:
                        DatasetView(
                            dataset: Dataset(
                                name: "Dataset.Tangolist",
                                fileName: "Wordlist-JP",
                                fileExtension: "txt"
                            )
                        )
                    case .moreCountries:
                        CountriesView()
                    case .moreAttributions:
                        LicensesView(licenses: [
                            License(libraryName: "english-words", text:
"""
This app uses data from the repository english-words.
For more information, visit https://github.com/dwyl/english-words.
"""),
                            License(libraryName: "japanese", text:
"""
This app uses data from the repository japanese, which is licensed by the Creative Commons (CC BY) Attribution.
For more information, visit https://github.com/hingston/japanese.
License information can be found at https://creativecommons.org/licenses/by/2.5/.
""")
                        ])
                    default:
                        Color.clear
                    }
                })
            .navigationTitle("View.More")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    if #available(iOS 26.0, *) {
                        Button(role: .close) {
                            showingMoreSheet = false
                        }
                    } else {
                        Button("Shared.Done") {
                            showingMoreSheet = false
                        }
                    }
                }
            }
        }
        .presentationDetents([.medium, .large])
    }
}
