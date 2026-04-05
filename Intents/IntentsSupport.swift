//
//  IntentsSupport.swift
//  Intents
//
//  Created by シン・ジャスティン on 2026/04/03.
//

import AppIntents
import Foundation

// MARK: - Select Country

struct SelectCountry: AppIntent {
    static var title: LocalizedStringResource { "Intent.SelectCountry.Title" }
    static var description: IntentDescription { "Intent.SelectCountry.Description" }

    func perform() async throws -> some IntentResult & ReturnsValue<String> {
        let countries = CountryData.allCountries
        guard let country = countries.randomElement() else {
            throw IntentError.wordlistUnavailable
        }
        return .result(value: "\(country.name) (\(country.isoCode))")
    }
}

// MARK: - Country Data (for Intents Extension)

private struct CountryData {
    struct Country {
        let name: String
        let isoCode: String
    }

    static let allCountries: [Country] = [
        Country(name: "Afghanistan", isoCode: "AF"),
        Country(name: "Albania", isoCode: "AL"),
        Country(name: "Algeria", isoCode: "DZ"),
        Country(name: "Andorra", isoCode: "AD"),
        Country(name: "Angola", isoCode: "AO"),
        Country(name: "Antigua and Barbuda", isoCode: "AG"),
        Country(name: "Argentina", isoCode: "AR"),
        Country(name: "Armenia", isoCode: "AM"),
        Country(name: "Australia", isoCode: "AU"),
        Country(name: "Austria", isoCode: "AT"),
        Country(name: "Azerbaijan", isoCode: "AZ"),
        Country(name: "Bahamas", isoCode: "BS"),
        Country(name: "Bahrain", isoCode: "BH"),
        Country(name: "Bangladesh", isoCode: "BD"),
        Country(name: "Barbados", isoCode: "BB"),
        Country(name: "Belarus", isoCode: "BY"),
        Country(name: "Belgium", isoCode: "BE"),
        Country(name: "Belize", isoCode: "BZ"),
        Country(name: "Benin", isoCode: "BJ"),
        Country(name: "Bhutan", isoCode: "BT"),
        Country(name: "Bolivia", isoCode: "BO"),
        Country(name: "Bosnia and Herzegovina", isoCode: "BA"),
        Country(name: "Botswana", isoCode: "BW"),
        Country(name: "Brazil", isoCode: "BR"),
        Country(name: "Brunei", isoCode: "BN"),
        Country(name: "Bulgaria", isoCode: "BG"),
        Country(name: "Burkina Faso", isoCode: "BF"),
        Country(name: "Burundi", isoCode: "BI"),
        Country(name: "Cabo Verde", isoCode: "CV"),
        Country(name: "Cambodia", isoCode: "KH"),
        Country(name: "Cameroon", isoCode: "CM"),
        Country(name: "Canada", isoCode: "CA"),
        Country(name: "Central African Republic", isoCode: "CF"),
        Country(name: "Chad", isoCode: "TD"),
        Country(name: "Chile", isoCode: "CL"),
        Country(name: "China", isoCode: "CN"),
        Country(name: "Colombia", isoCode: "CO"),
        Country(name: "Comoros", isoCode: "KM"),
        Country(name: "Congo", isoCode: "CG"),
        Country(name: "Costa Rica", isoCode: "CR"),
        Country(name: "Croatia", isoCode: "HR"),
        Country(name: "Cuba", isoCode: "CU"),
        Country(name: "Cyprus", isoCode: "CY"),
        Country(name: "Czech Republic", isoCode: "CZ"),
        Country(name: "Denmark", isoCode: "DK"),
        Country(name: "Djibouti", isoCode: "DJ"),
        Country(name: "Dominica", isoCode: "DM"),
        Country(name: "Dominican Republic", isoCode: "DO"),
        Country(name: "DR Congo", isoCode: "CD"),
        Country(name: "Ecuador", isoCode: "EC"),
        Country(name: "Egypt", isoCode: "EG"),
        Country(name: "El Salvador", isoCode: "SV"),
        Country(name: "Equatorial Guinea", isoCode: "GQ"),
        Country(name: "Eritrea", isoCode: "ER"),
        Country(name: "Estonia", isoCode: "EE"),
        Country(name: "Eswatini", isoCode: "SZ"),
        Country(name: "Ethiopia", isoCode: "ET"),
        Country(name: "Fiji", isoCode: "FJ"),
        Country(name: "Finland", isoCode: "FI"),
        Country(name: "France", isoCode: "FR"),
        Country(name: "Gabon", isoCode: "GA"),
        Country(name: "Gambia", isoCode: "GM"),
        Country(name: "Georgia", isoCode: "GE"),
        Country(name: "Germany", isoCode: "DE"),
        Country(name: "Ghana", isoCode: "GH"),
        Country(name: "Greece", isoCode: "GR"),
        Country(name: "Grenada", isoCode: "GD"),
        Country(name: "Guatemala", isoCode: "GT"),
        Country(name: "Guinea", isoCode: "GN"),
        Country(name: "Guinea-Bissau", isoCode: "GW"),
        Country(name: "Guyana", isoCode: "GY"),
        Country(name: "Haiti", isoCode: "HT"),
        Country(name: "Honduras", isoCode: "HN"),
        Country(name: "Hungary", isoCode: "HU"),
        Country(name: "Iceland", isoCode: "IS"),
        Country(name: "India", isoCode: "IN"),
        Country(name: "Indonesia", isoCode: "ID"),
        Country(name: "Iran", isoCode: "IR"),
        Country(name: "Iraq", isoCode: "IQ"),
        Country(name: "Ireland", isoCode: "IE"),
        Country(name: "Israel", isoCode: "IL"),
        Country(name: "Italy", isoCode: "IT"),
        Country(name: "Ivory Coast", isoCode: "CI"),
        Country(name: "Jamaica", isoCode: "JM"),
        Country(name: "Japan", isoCode: "JP"),
        Country(name: "Jordan", isoCode: "JO"),
        Country(name: "Kazakhstan", isoCode: "KZ"),
        Country(name: "Kenya", isoCode: "KE"),
        Country(name: "Kiribati", isoCode: "KI"),
        Country(name: "Kuwait", isoCode: "KW"),
        Country(name: "Kyrgyzstan", isoCode: "KG"),
        Country(name: "Laos", isoCode: "LA"),
        Country(name: "Latvia", isoCode: "LV"),
        Country(name: "Lebanon", isoCode: "LB"),
        Country(name: "Lesotho", isoCode: "LS"),
        Country(name: "Liberia", isoCode: "LR"),
        Country(name: "Libya", isoCode: "LY"),
        Country(name: "Liechtenstein", isoCode: "LI"),
        Country(name: "Lithuania", isoCode: "LT"),
        Country(name: "Luxembourg", isoCode: "LU"),
        Country(name: "Madagascar", isoCode: "MG"),
        Country(name: "Malawi", isoCode: "MW"),
        Country(name: "Malaysia", isoCode: "MY"),
        Country(name: "Maldives", isoCode: "MV"),
        Country(name: "Mali", isoCode: "ML"),
        Country(name: "Malta", isoCode: "MT"),
        Country(name: "Marshall Islands", isoCode: "MH"),
        Country(name: "Mauritania", isoCode: "MR"),
        Country(name: "Mauritius", isoCode: "MU"),
        Country(name: "Mexico", isoCode: "MX"),
        Country(name: "Micronesia", isoCode: "FM"),
        Country(name: "Moldova", isoCode: "MD"),
        Country(name: "Monaco", isoCode: "MC"),
        Country(name: "Mongolia", isoCode: "MN"),
        Country(name: "Montenegro", isoCode: "ME"),
        Country(name: "Morocco", isoCode: "MA"),
        Country(name: "Mozambique", isoCode: "MZ"),
        Country(name: "Myanmar", isoCode: "MM"),
        Country(name: "Namibia", isoCode: "NA"),
        Country(name: "Nauru", isoCode: "NR"),
        Country(name: "Nepal", isoCode: "NP"),
        Country(name: "Netherlands", isoCode: "NL"),
        Country(name: "New Zealand", isoCode: "NZ"),
        Country(name: "Nicaragua", isoCode: "NI"),
        Country(name: "Niger", isoCode: "NE"),
        Country(name: "Nigeria", isoCode: "NG"),
        Country(name: "North Korea", isoCode: "KP"),
        Country(name: "North Macedonia", isoCode: "MK"),
        Country(name: "Norway", isoCode: "NO"),
        Country(name: "Oman", isoCode: "OM"),
        Country(name: "Pakistan", isoCode: "PK"),
        Country(name: "Palau", isoCode: "PW"),
        Country(name: "Palestine", isoCode: "PS"),
        Country(name: "Panama", isoCode: "PA"),
        Country(name: "Papua New Guinea", isoCode: "PG"),
        Country(name: "Paraguay", isoCode: "PY"),
        Country(name: "Peru", isoCode: "PE"),
        Country(name: "Philippines", isoCode: "PH"),
        Country(name: "Poland", isoCode: "PL"),
        Country(name: "Portugal", isoCode: "PT"),
        Country(name: "Qatar", isoCode: "QA"),
        Country(name: "Romania", isoCode: "RO"),
        Country(name: "Russia", isoCode: "RU"),
        Country(name: "Rwanda", isoCode: "RW"),
        Country(name: "Saint Kitts and Nevis", isoCode: "KN"),
        Country(name: "Saint Lucia", isoCode: "LC"),
        Country(name: "Saint Vincent and the Grenadines", isoCode: "VC"),
        Country(name: "Samoa", isoCode: "WS"),
        Country(name: "San Marino", isoCode: "SM"),
        Country(name: "Sao Tome and Principe", isoCode: "ST"),
        Country(name: "Saudi Arabia", isoCode: "SA"),
        Country(name: "Senegal", isoCode: "SN"),
        Country(name: "Serbia", isoCode: "RS"),
        Country(name: "Seychelles", isoCode: "SC"),
        Country(name: "Sierra Leone", isoCode: "SL"),
        Country(name: "Singapore", isoCode: "SG"),
        Country(name: "Slovakia", isoCode: "SK"),
        Country(name: "Slovenia", isoCode: "SI"),
        Country(name: "Solomon Islands", isoCode: "SB"),
        Country(name: "Somalia", isoCode: "SO"),
        Country(name: "South Africa", isoCode: "ZA"),
        Country(name: "South Korea", isoCode: "KR"),
        Country(name: "South Sudan", isoCode: "SS"),
        Country(name: "Spain", isoCode: "ES"),
        Country(name: "Sri Lanka", isoCode: "LK"),
        Country(name: "Sudan", isoCode: "SD"),
        Country(name: "Suriname", isoCode: "SR"),
        Country(name: "Sweden", isoCode: "SE"),
        Country(name: "Switzerland", isoCode: "CH"),
        Country(name: "Syria", isoCode: "SY"),
        Country(name: "Taiwan", isoCode: "TW"),
        Country(name: "Tajikistan", isoCode: "TJ"),
        Country(name: "Tanzania", isoCode: "TZ"),
        Country(name: "Thailand", isoCode: "TH"),
        Country(name: "Timor-Leste", isoCode: "TL"),
        Country(name: "Togo", isoCode: "TG"),
        Country(name: "Tonga", isoCode: "TO"),
        Country(name: "Trinidad and Tobago", isoCode: "TT"),
        Country(name: "Tunisia", isoCode: "TN"),
        Country(name: "Turkey", isoCode: "TR"),
        Country(name: "Turkmenistan", isoCode: "TM"),
        Country(name: "Tuvalu", isoCode: "TV"),
        Country(name: "Uganda", isoCode: "UG"),
        Country(name: "Ukraine", isoCode: "UA"),
        Country(name: "United Arab Emirates", isoCode: "AE"),
        Country(name: "United Kingdom", isoCode: "GB"),
        Country(name: "United States", isoCode: "US"),
        Country(name: "Uruguay", isoCode: "UY"),
        Country(name: "Uzbekistan", isoCode: "UZ"),
        Country(name: "Vanuatu", isoCode: "VU"),
        Country(name: "Vatican City", isoCode: "VA"),
        Country(name: "Venezuela", isoCode: "VE"),
        Country(name: "Vietnam", isoCode: "VN"),
        Country(name: "Yemen", isoCode: "YE"),
        Country(name: "Zambia", isoCode: "ZM"),
        Country(name: "Zimbabwe", isoCode: "ZW")
    ]
}

// MARK: - Shortcuts Provider

struct RandomlyShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: GenerateNumberInRange(),
            phrases: [
                "Generate a random number with \(.applicationName)",
                "Pick a random number with \(.applicationName)"
            ],
            shortTitle: "Intent.Shortcut.GenerateNumber",
            systemImageName: "number"
        )
        AppShortcut(
            intent: GenerateWord(),
            phrases: [
                "Generate a random word with \(.applicationName)"
            ],
            shortTitle: "Intent.Shortcut.GenerateWord",
            systemImageName: "textformat"
        )
        AppShortcut(
            intent: GeneratePassword(),
            phrases: [
                "Generate a random password with \(.applicationName)"
            ],
            shortTitle: "Intent.Shortcut.GeneratePassword",
            systemImageName: "key"
        )
        AppShortcut(
            intent: SelectEmoji(),
            phrases: [
                "Pick a random emoji with \(.applicationName)"
            ],
            shortTitle: "Intent.Shortcut.SelectEmoji",
            systemImageName: "face.smiling"
        )
        AppShortcut(
            intent: SelectCountry(),
            phrases: [
                "Pick a random country with \(.applicationName)"
            ],
            shortTitle: "Intent.Shortcut.SelectCountry",
            systemImageName: "globe"
        )
    }
}

// MARK: - Errors

enum IntentError: Error, CustomLocalizedStringResourceConvertible {
    case invalidRange
    case noCharacterSets
    case wordlistUnavailable

    var localizedStringResource: LocalizedStringResource {
        switch self {
        case .invalidRange:
            "Intent.Error.InvalidRange"
        case .noCharacterSets:
            "Intent.Error.NoCharacterSets"
        case .wordlistUnavailable:
            "Intent.Error.WordlistUnavailable"
        }
    }
}

// MARK: - Helpers

extension String {
    func capitalizingFirst() -> String {
        prefix(1).uppercased() + dropFirst()
    }
}
