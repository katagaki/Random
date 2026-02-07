//
//  RandomlyView.swift
//  Random
//
//  Created by シンジャスティン on 2023/08/26.
//

import SwiftUI

struct RandomlyView: View {

    @EnvironmentObject var navigationManager: NavigationManager
    @State private var showingMoreSheet = false

    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        NavigationStack(path: $navigationManager.randomlyTabPath) {
            ScrollView {
                VStack(alignment: .leading, spacing: 28.0) {
                    VStack(alignment: .leading, spacing: 12) {
                        ListSectionHeader(text: "Shared.Pick")
                            .font(.body)
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 12) {
                            GridCardView(destination: ViewPath.pickNumber, title: "Select.Number",
                                         icon: "number", iconColor: .blue)
                            GridCardView(destination: ViewPath.pickLetter, title: "Select.Letter",
                                         icon: "character", iconColor: .green)

                            switch Locale.current.language.languageCode ?? .english {
                            case .japanese:
                                GridCardView(destination: ViewPath.pickWordJapanese, title: "Select.Word",
                                             icon: "textformat.abc", iconColor: .teal)
                            default:
                                GridCardView(destination: ViewPath.pickWordEnglish, title: "Select.Word",
                                             icon: "textformat.abc", iconColor: .teal)
                            }

                            GridCardView(destination: ViewPath.pickDate, title: "Generate.Date",
                                         icon: "calendar", iconColor: .red)
                            GridCardView(destination: ViewPath.pickTime, title: "Generate.Time",
                                         icon: "clock.fill", iconColor: .red)
                            GridCardView(destination: ViewPath.pickCountry, title: "Generate.Country",
                                         icon: "globe", iconColor: .purple)
                        }
                        .padding(.horizontal)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        ListSectionHeader(text: "Shared.Generate")
                            .font(.body)
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 12) {
                            GridCardView(destination: ViewPath.generateWord, title: "Generate.Word",
                                         icon: "textformat.abc", iconColor: .teal)
                            GridCardView(destination: ViewPath.generatePassword, title: "Generate.Password",
                                         icon: "key.fill", iconColor: .orange)
                            GridCardView(destination: ViewPath.generateColor, title: "Generate.Color",
                                         icon: "paintpalette.fill",
                                         iconGradient: LinearGradient(
                                             colors: [.red, .orange, .yellow, .green, .cyan, .blue, .purple],
                                             startPoint: .leading,
                                             endPoint: .trailing
                                         ))
                            GridCardView(destination: ViewPath.generateCoordinate, title: "Generate.Coordinate",
                                         icon: "mappin.and.ellipse", iconColor: .blue)
                        }
                        .padding(.horizontal)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        ListSectionHeader(text: "Shared.Select")
                            .font(.body)
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 12) {
                            GridCardView(destination: ViewPath.selectItemFromList, title: "Select.ItemFromList",
                                         icon: "list.bullet", iconColor: .indigo)
                            GridCardView(destination: ViewPath.selectWordFromText, title: "Select.WordFromText",
                                         icon: "doc.text", iconColor: .teal)
                        }
                        .padding(.horizontal)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        ListSectionHeader(text: "Shared.Shuffle")
                            .font(.body)
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 12) {
                            GridCardView(destination: ViewPath.shuffleList, title: "Shuffle.List",
                                         icon: "list.bullet", iconColor: .mint)
                            GridCardView(destination: ViewPath.shuffleDict, title: "Shuffle.Dictionary",
                                         icon: "tablecells", iconColor: .brown)
                        }
                        .padding(.horizontal)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        ListSectionHeader(text: "Shared.Sort")
                            .font(.body)
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 12) {
                            GridCardView(destination: ViewPath.sortList, title: "Sort.List",
                                         icon: "list.bullet", iconColor: .mint)
                            GridCardView(destination: ViewPath.sortDict, title: "Sort.Dictionary",
                                         icon: "tablecells", iconColor: .brown)
                        }
                        .padding(.horizontal)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        ListSectionHeader(text: "Shared.Count")
                            .font(.body)
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 12) {
                            GridCardView(destination: ViewPath.countUp, title: "Count.Up",
                                         icon: "plus.circle.fill", iconColor: Locale.current.language.languageCode == .japanese ? .red : .green)
                            GridCardView(destination: ViewPath.countDown, title: "Count.Down",
                                         icon: "minus.circle.fill", iconColor: Locale.current.language.languageCode == .japanese ? .blue : .red)
                        }
                        .padding(.horizontal)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        ListSectionHeader(text: "Shared.OtherFeatures")
                            .font(.body)
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 12) {
                            GridCardView(destination: ViewPath.tossCoin, title: "Do.CoinFlip",
                                         icon: "centsign.circle.fill", iconColor: .yellow)
                            GridCardView(destination: ViewPath.rollDice, title: "Do.DiceRoll",
                                         icon: "die.face.5.fill", iconColor: .red)
                            GridCardView(destination: ViewPath.drawCard, title: "Do.CardDraw",
                                         icon: "square.on.square.fill", iconColor: .gray)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .background(Color(.systemGroupedBackground))
            .navigationDestination(for: ViewPath.self, destination: { viewPath in
                switch viewPath {
                case .pickNumber:
                    PickNumberLetterWordView(mode: .number)
                case .pickLetter:
                    PickNumberLetterWordView(mode: .letter)
                case .pickWordEnglish:
                    PickNumberLetterWordView(mode: .englishWord)
                case .pickWordJapanese:
                    PickNumberLetterWordView(mode: .japaneseWord)
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
                case .generateWord:
                    GenerateWordView()
                case .selectItemFromList:
                    SelectItemFromListView()
                case .selectWordFromText:
                    SelectWordFromTextView()
                case .shuffleList:
                    ShuffleListView()
                case .shuffleDict:
                    ShuffleDictionaryView()
                case .sortList:
                    SortListView()
                case .sortDict:
                    SortDictionaryView()
                case .countUp:
                    CountUpView()
                case .countDown:
                    CountDownView()
                case .tossCoin:
                    TossCoinView()
                case .rollDice:
                    RollDiceView()
                case .drawCard:
                    DrawCardView()
                default:
                    Color.clear
                }
            })
            .navigationTitle("View.Randomly")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingMoreSheet = true
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                }
            }
            .sheet(isPresented: $showingMoreSheet) {
                NavigationStack {
                    MoreList(repoName: "katagaki/Random", viewPath: ViewPath.moreAttributions) {
                        Section {
                            NavigationLink(value: ViewPath.moreDatasets) {
                                Label("More.Datasets", systemImage: "cylinder.split.1x2")
                            }
                        } header: {
                            ListSectionHeader(text: "More.General")
                                .font(.body)
                        }
                    }
                    .navigationDestination(for: ViewPath.self, destination: { viewPath in
                        switch viewPath {
                        case .moreDatasets:
                            DatasetsView()
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
            }
        }
    }
}
