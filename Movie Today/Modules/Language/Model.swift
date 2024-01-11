//
//  Model.swift
//  Movie Today
//
//  Created by Юрий on 11.01.2024.
//

import Foundation

struct Language {
    let name: String
    var group: Group
}

enum Group {
    case suggestedLanguages
    case otherLanguage
}

struct Source {
    static func languages() -> [Language] {
        [
            .init(name: "English(UK)", group: .suggestedLanguages),
            .init(name: "English", group: .suggestedLanguages),
            .init(name: "Bahasa Indonesia", group: .suggestedLanguages),
            .init(name: "Chineses", group: .otherLanguage),
            .init(name: "Croatian", group: .otherLanguage),
            .init(name: "Czech", group: .otherLanguage),
            .init(name: "Danish", group: .otherLanguage),
            .init(name: "Filipino", group: .otherLanguage),
            .init(name: "Finnish", group: .otherLanguage)
        ]
    }
    
    static func makeLanguageWithGroup() -> [[Language]] {
        let suggestedLanguages = languages().filter { $0.group == .suggestedLanguages }
        let otherLanguage = languages().filter { $0.group == .otherLanguage}
        return [suggestedLanguages, otherLanguage]
    }
}
