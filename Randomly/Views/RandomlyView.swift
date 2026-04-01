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
                        ListSectionHeader(text: "Shared.Numbers")
                            .font(.body)
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 12) {
                            GridCardView(destination: ViewPath.pickNumber, title: "Select.Number",
                                         icon: "number", iconColor: .blue)
                            GridCardView(destination: ViewPath.generateNumberSequence, title: "Generate.NumberSequence",
                                         icon: "list.number", iconColor: .cyan)
                        }
                        .padding(.horizontal)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        ListSectionHeader(text: "Shared.Text")
                            .font(.body)
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 12) {
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

                            GridCardView(destination: ViewPath.pickEmoji, title: "Select.Emoji",
                                         icon: "face.smiling.inverse", iconColor: .yellow)
                            GridCardView(destination: ViewPath.generateWord, title: "Generate.Word",
                                         icon: "textformat.abc", iconColor: .teal)
                            GridCardView(destination: ViewPath.generateLoremIpsum, title: "Generate.LoremIpsum",
                                         icon: "text.alignleft", iconColor: .gray)
                            GridCardView(destination: ViewPath.selectWordFromText, title: "Select.WordFromText",
                                         icon: "doc.text", iconColor: .teal)
                            GridCardView(destination: ViewPath.shuffleLetters, title: "Shuffle.Letters",
                                         icon: "textformat.abc", iconColor: .pink)
                        }
                        .padding(.horizontal)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        ListSectionHeader(text: "Shared.DateTimeTools")
                            .font(.body)
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 12) {
                            GridCardView(destination: ViewPath.pickDate, title: "Generate.Date",
                                         icon: "calendar", iconColor: .red)
                            GridCardView(destination: ViewPath.pickTime, title: "Generate.Time",
                                         icon: "clock.fill", iconColor: .red)
                            GridCardView(destination: ViewPath.pickDayOfWeek, title: "Pick.DayOfWeek",
                                         icon: "calendar.day.timeline.left", iconColor: .orange)
                            GridCardView(destination: ViewPath.pickMonth, title: "Pick.Month",
                                         icon: "calendar.circle", iconColor: .pink)
                        }
                        .padding(.horizontal)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        ListSectionHeader(text: "Shared.ListTools")
                            .font(.body)
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 12) {
                            GridCardView(destination: ViewPath.selectItemFromList, title: "Select.ItemFromList",
                                         icon: "list.bullet", iconColor: .indigo)
                            GridCardView(destination: ViewPath.selectGroupFromList, title: "Select.Group",
                                         icon: "person.3.fill", iconColor: .orange)
                            GridCardView(destination: ViewPath.shuffleList, title: "Shuffle.List",
                                         icon: "shuffle", iconColor: .mint)
                            GridCardView(destination: ViewPath.sortList, title: "Sort.List",
                                         icon: "arrow.up.arrow.down", iconColor: .mint)
                            GridCardView(destination: ViewPath.groupList, title: "Group.List",
                                         icon: "rectangle.3.group", iconColor: .cyan)
                        }
                        .padding(.horizontal)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        ListSectionHeader(text: "Shared.DictionaryTools")
                            .font(.body)
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 12) {
                            GridCardView(destination: ViewPath.shuffleDict, title: "Shuffle.Dictionary",
                                         icon: "shuffle", iconColor: .brown)
                            GridCardView(destination: ViewPath.sortDict, title: "Sort.Dictionary",
                                         icon: "arrow.up.arrow.down", iconColor: .brown)
                        }
                        .padding(.horizontal)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        ListSectionHeader(text: "Shared.ChartTools")
                            .font(.body)
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 12) {
                            GridCardView(destination: ViewPath.chartBar, title: "Chart.Bar",
                                         icon: "chart.bar.fill", iconColor: .blue)
                            GridCardView(destination: ViewPath.chartPie, title: "Chart.Pie",
                                         icon: "chart.pie.fill", iconColor: .orange)
                            GridCardView(destination: ViewPath.chartLine, title: "Chart.Line",
                                         icon: "chart.xyaxis.line", iconColor: .green)
                            GridCardView(destination: ViewPath.chartScatter, title: "Chart.Scatter",
                                         icon: "chart.dots.scatter", iconColor: .purple)
                        }
                        .padding(.horizontal)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        ListSectionHeader(text: "Shared.Simulators")
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

                    VStack(alignment: .leading, spacing: 12) {
                        ListSectionHeader(text: "Shared.Counters")
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
                        ListSectionHeader(text: "Shared.Others")
                            .font(.body)
                            .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 12) {
                            GridCardView(destination: ViewPath.generatePassword, title: "Generate.Password",
                                         icon: "key.fill", iconColor: .orange)
                            GridCardView(destination: ViewPath.generatePassphrase, title: "Generate.Passphrase",
                                         icon: "lock.shield", iconColor: .green)
                            GridCardView(destination: ViewPath.generateUUID, title: "Generate.UUID",
                                         icon: "number.square", iconColor: .indigo)
                            GridCardView(destination: ViewPath.pickCountry, title: "Generate.Country",
                                         icon: "globe", iconColor: .purple)
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
                }
                .padding(.vertical)
            }
            .background(
                LinearGradient(
                    colors: [Color("BackgroundGradientTop"), Color("BackgroundGradientBottom")],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
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
                case .generateWord:
                    GenerateWordView()
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
                case .generateUUID:
                    GenerateUUIDView()
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
                                Text("More.Datasets")
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
                .presentationDetents([.medium, .large])
            }
        }
    }
}
