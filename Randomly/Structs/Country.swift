//
//  Country.swift
//  Random
//
//  Created by シンジャスティン on 2026/02/05.
//

import Foundation

struct Country: Identifiable, Hashable {
    var id = UUID()
    var nameKey: String // Localization key
    var name: String {
        NSLocalizedString(nameKey, comment: "")
    }
    var isoCode: String
    var countryCode: String
    var timeZone: String
    
    static let allCountries: [Country] = [
        Country(nameKey: "Country.UnitedStates", isoCode: "US", countryCode: "+1", timeZone: "America/New_York"),
        Country(nameKey: "Country.UnitedKingdom", isoCode: "GB", countryCode: "+44", timeZone: "Europe/London"),
        Country(nameKey: "Country.Canada", isoCode: "CA", countryCode: "+1", timeZone: "America/Toronto"),
        Country(nameKey: "Country.Australia", isoCode: "AU", countryCode: "+61", timeZone: "Australia/Sydney"),
        Country(nameKey: "Country.Germany", isoCode: "DE", countryCode: "+49", timeZone: "Europe/Berlin"),
        Country(nameKey: "Country.France", isoCode: "FR", countryCode: "+33", timeZone: "Europe/Paris"),
        Country(nameKey: "Country.Japan", isoCode: "JP", countryCode: "+81", timeZone: "Asia/Tokyo"),
        Country(nameKey: "Country.China", isoCode: "CN", countryCode: "+86", timeZone: "Asia/Shanghai"),
        Country(nameKey: "Country.India", isoCode: "IN", countryCode: "+91", timeZone: "Asia/Kolkata"),
        Country(nameKey: "Country.Brazil", isoCode: "BR", countryCode: "+55", timeZone: "America/Sao_Paulo"),
        Country(nameKey: "Country.Mexico", isoCode: "MX", countryCode: "+52", timeZone: "America/Mexico_City"),
        Country(nameKey: "Country.Italy", isoCode: "IT", countryCode: "+39", timeZone: "Europe/Rome"),
        Country(nameKey: "Country.Spain", isoCode: "ES", countryCode: "+34", timeZone: "Europe/Madrid"),
        Country(nameKey: "Country.SouthKorea", isoCode: "KR", countryCode: "+82", timeZone: "Asia/Seoul"),
        Country(nameKey: "Country.Netherlands", isoCode: "NL", countryCode: "+31", timeZone: "Europe/Amsterdam"),
        Country(nameKey: "Country.Sweden", isoCode: "SE", countryCode: "+46", timeZone: "Europe/Stockholm"),
        Country(nameKey: "Country.Switzerland", isoCode: "CH", countryCode: "+41", timeZone: "Europe/Zurich"),
        Country(nameKey: "Country.Norway", isoCode: "NO", countryCode: "+47", timeZone: "Europe/Oslo"),
        Country(nameKey: "Country.Denmark", isoCode: "DK", countryCode: "+45", timeZone: "Europe/Copenhagen"),
        Country(nameKey: "Country.Finland", isoCode: "FI", countryCode: "+358", timeZone: "Europe/Helsinki"),
        Country(nameKey: "Country.Poland", isoCode: "PL", countryCode: "+48", timeZone: "Europe/Warsaw"),
        Country(nameKey: "Country.Belgium", isoCode: "BE", countryCode: "+32", timeZone: "Europe/Brussels"),
        Country(nameKey: "Country.Austria", isoCode: "AT", countryCode: "+43", timeZone: "Europe/Vienna"),
        Country(nameKey: "Country.Portugal", isoCode: "PT", countryCode: "+351", timeZone: "Europe/Lisbon"),
        Country(nameKey: "Country.Greece", isoCode: "GR", countryCode: "+30", timeZone: "Europe/Athens"),
        Country(nameKey: "Country.CzechRepublic", isoCode: "CZ", countryCode: "+420", timeZone: "Europe/Prague"),
        Country(nameKey: "Country.Ireland", isoCode: "IE", countryCode: "+353", timeZone: "Europe/Dublin"),
        Country(nameKey: "Country.NewZealand", isoCode: "NZ", countryCode: "+64", timeZone: "Pacific/Auckland"),
        Country(nameKey: "Country.Singapore", isoCode: "SG", countryCode: "+65", timeZone: "Asia/Singapore"),
        Country(nameKey: "Country.Thailand", isoCode: "TH", countryCode: "+66", timeZone: "Asia/Bangkok"),
        Country(nameKey: "Country.Malaysia", isoCode: "MY", countryCode: "+60", timeZone: "Asia/Kuala_Lumpur"),
        Country(nameKey: "Country.Indonesia", isoCode: "ID", countryCode: "+62", timeZone: "Asia/Jakarta"),
        Country(nameKey: "Country.Philippines", isoCode: "PH", countryCode: "+63", timeZone: "Asia/Manila"),
        Country(nameKey: "Country.Vietnam", isoCode: "VN", countryCode: "+84", timeZone: "Asia/Ho_Chi_Minh"),
        Country(nameKey: "Country.SouthAfrica", isoCode: "ZA", countryCode: "+27", timeZone: "Africa/Johannesburg"),
        Country(nameKey: "Country.Egypt", isoCode: "EG", countryCode: "+20", timeZone: "Africa/Cairo"),
        Country(nameKey: "Country.Turkey", isoCode: "TR", countryCode: "+90", timeZone: "Europe/Istanbul"),
        Country(nameKey: "Country.Russia", isoCode: "RU", countryCode: "+7", timeZone: "Europe/Moscow"),
        Country(nameKey: "Country.Ukraine", isoCode: "UA", countryCode: "+380", timeZone: "Europe/Kiev"),
        Country(nameKey: "Country.Argentina", isoCode: "AR", countryCode: "+54", timeZone: "America/Argentina/Buenos_Aires"),
        Country(nameKey: "Country.Chile", isoCode: "CL", countryCode: "+56", timeZone: "America/Santiago"),
        Country(nameKey: "Country.Colombia", isoCode: "CO", countryCode: "+57", timeZone: "America/Bogota"),
        Country(nameKey: "Country.Peru", isoCode: "PE", countryCode: "+51", timeZone: "America/Lima"),
        Country(nameKey: "Country.Venezuela", isoCode: "VE", countryCode: "+58", timeZone: "America/Caracas"),
        Country(nameKey: "Country.Israel", isoCode: "IL", countryCode: "+972", timeZone: "Asia/Jerusalem"),
        Country(nameKey: "Country.UnitedArabEmirates", isoCode: "AE", countryCode: "+971", timeZone: "Asia/Dubai"),
        Country(nameKey: "Country.SaudiArabia", isoCode: "SA", countryCode: "+966", timeZone: "Asia/Riyadh"),
        Country(nameKey: "Country.Nigeria", isoCode: "NG", countryCode: "+234", timeZone: "Africa/Lagos"),
        Country(nameKey: "Country.Kenya", isoCode: "KE", countryCode: "+254", timeZone: "Africa/Nairobi"),
        Country(nameKey: "Country.Pakistan", isoCode: "PK", countryCode: "+92", timeZone: "Asia/Karachi")
    ]
}
