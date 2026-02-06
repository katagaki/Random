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
                        ListSectionHeader(text: "Shared.Select")
                            .font(.body)
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 12) {
                            GridCardView(destination: ViewPath.selectNumber, title: "Randomly.Generate.Number",
                                         icon: "number", iconColor: .blue)
                            GridCardView(destination: ViewPath.selectLetter, title: "Randomly.Generate.Letter",
                                         icon: "character", iconColor: .green)

                            switch Locale.current.language.languageCode ?? .english {
                            case .japanese:
                                GridCardView(destination: ViewPath.selectWordJapanese, title: "Randomly.Generate.Word",
                                             icon: "textformat", iconColor: .teal)
                            default:
                                GridCardView(destination: ViewPath.selectWordEnglish, title: "Randomly.Generate.Word",
                                             icon: "textformat", iconColor: .teal)
                            }

                            GridCardView(destination: ViewPath.selectDate, title: "Randomly.Generate.Date",
                                         icon: "calendar", iconColor: .red)
                            GridCardView(destination: ViewPath.selectTime, title: "Randomly.Generate.Time",
                                         icon: "clock.fill", iconColor: .red)
                            GridCardView(destination: ViewPath.selectCountry, title: "Randomly.Generate.Country",
                                         icon: "globe", iconColor: .purple)
                        }
                        .padding(.horizontal)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        ListSectionHeader(text: "Shared.Generate")
                            .font(.body)
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 12) {
                            GridCardView(destination: ViewPath.generatePassword, title: "Randomly.Generate.Password",
                                         icon: "key.fill", iconColor: .orange)
                            GridCardView(destination: ViewPath.generateColor, title: "Randomly.Generate.Color",
                                         icon: "paintpalette.fill",
                                         iconGradient: LinearGradient(
                                             colors: [.red, .orange, .yellow, .green, .cyan, .blue, .purple],
                                             startPoint: .leading,
                                             endPoint: .trailing
                                         ))
                        }
                        .padding(.horizontal)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        ListSectionHeader(text: "Shared.Pick")
                            .font(.body)
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 12) {
                            GridCardView(destination: ViewPath.selectItemFromList, title: "Randomly.Select.ItemFromList",
                                         icon: "list.bullet", iconColor: .indigo)
                            GridCardView(destination: ViewPath.selectWordFromText, title: "Randomly.Select.WordFromText",
                                         icon: "doc.text", iconColor: .teal)
                        }
                        .padding(.horizontal)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        ListSectionHeader(text: "Shared.Shuffle")
                            .font(.body)
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 12) {
                            GridCardView(destination: ViewPath.shuffleList, title: "Randomly.Shuffle.List",
                                         icon: "list.bullet", iconColor: .mint)
                            GridCardView(destination: ViewPath.shuffleDict, title: "Randomly.Shuffle.Dictionary",
                                         icon: "tablecells", iconColor: .brown)
                        }
                        .padding(.horizontal)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        ListSectionHeader(text: "Shared.Sort")
                            .font(.body)
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 12) {
                            GridCardView(destination: ViewPath.sortList, title: "Neatly.Sort.List",
                                         icon: "list.bullet", iconColor: .mint)
                            GridCardView(destination: ViewPath.sortDict, title: "Neatly.Sort.Dictionary",
                                         icon: "tablecells", iconColor: .brown)
                        }
                        .padding(.horizontal)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        ListSectionHeader(text: "Shared.Count")
                            .font(.body)
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 12) {
                            GridCardView(destination: ViewPath.countUp, title: "Randomly.Count.Up",
                                         icon: "plus.circle.fill", iconColor: Locale.current.language.languageCode == .japanese ? .red : .green)
                            GridCardView(destination: ViewPath.countDown, title: "Randomly.Count.Down",
                                         icon: "minus.circle.fill", iconColor: Locale.current.language.languageCode == .japanese ? .blue : .red)
                        }
                        .padding(.horizontal)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        ListSectionHeader(text: "Shared.OtherFeatures")
                            .font(.body)
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 12) {
                            GridCardView(destination: ViewPath.tossCoin, title: "Randomly.Do.CoinFlip",
                                         icon: "centsign.circle.fill", iconColor: .yellow)
                            GridCardView(destination: ViewPath.rollDice, title: "Randomly.Do.DiceRoll",
                                         icon: "die.face.5.fill", iconColor: .red)
                            GridCardView(destination: ViewPath.drawCard, title: "Randomly.Do.CardDraw",
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
                case .selectNumber:
                    SelectView(mode: .number)
                case .selectLetter:
                    SelectView(mode: .letter)
                case .selectWordEnglish:
                    SelectView(mode: .englishWord)
                case .selectWordJapanese:
                    SelectView(mode: .japaneseWord)
                case .selectDate:
                    SelectDateView()
                case .selectTime:
                    SelectTimeView()
                case .selectCountry:
                    SelectCountryView()
                case .generatePassword:
                    GeneratePasswordView()
                case .generateColor:
                    GenerateColorView()
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
