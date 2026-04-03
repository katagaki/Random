//
//  Intents.swift
//  Intents
//
//  Created by シン・ジャスティン on 2026/04/03.
//

import AppIntents

struct Intents: AppIntent {
    static var title: LocalizedStringResource { "Intents" }
    
    func perform() async throws -> some IntentResult {
        return .result()
    }
}
