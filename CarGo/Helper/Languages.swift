//
//  Languages.swift
//  CarGo
//
//  Created by Andrei Mirica on 03.02.2023.
//

import Foundation

struct Language: Hashable, Identifiable {
    var name: String
    var id: String { name }
}

struct Languages {
    var languagesList: [Language] = []
    
    init() {
        languagesList.append(Language(name: "English"))
        languagesList.append(Language(name: "German"))
        languagesList.append(Language(name: "Russian"))
        languagesList.append(Language(name: "French"))
        languagesList.append(Language(name: "Italian"))
        languagesList.append(Language(name: "Portuguese"))
        languagesList.append(Language(name: "Polish"))
        languagesList.append(Language(name: "Serbo-Croatian"))
        languagesList.append(Language(name: "Turkish"))
        languagesList.append(Language(name: "Dutch"))
        languagesList.append(Language(name: "Swedish"))
        languagesList.append(Language(name: "Norwegian"))
        languagesList.append(Language(name: "Danish"))
        languagesList.append(Language(name: "Finnish"))
        languagesList.append(Language(name: "Icelandic"))
        languagesList.append(Language(name: "Greek"))
        languagesList.append(Language(name: "Hungarian"))
        languagesList.append(Language(name: "Czech"))
        languagesList.append(Language(name: "Slovak"))
        languagesList.append(Language(name: "Slovenian"))
        languagesList.append(Language(name: "Bulgarian"))
        languagesList.append(Language(name: "Romanian"))
        languagesList.append(Language(name: "Maltese"))
        languagesList.append(Language(name: "Latvian"))
        languagesList.append(Language(name: "Lithuanian"))
        languagesList.append(Language(name: "Estonian"))
        languagesList.append(Language(name: "Irish"))
        languagesList.append(Language(name: "Scottish Gaelic"))
        languagesList.append(Language(name: "Welsh"))
        languagesList.append(Language(name: "Breton"))
        languagesList.append(Language(name: "Catalan"))
        languagesList.append(Language(name: "Basque"))
        languagesList.append(Language(name: "Hindi"))
        languagesList.append(Language(name: "Japanese"))
        languagesList.append(Language(name: "Chinese"))
        
        languagesList.sort { $0.name < $1.name }
    }
}
