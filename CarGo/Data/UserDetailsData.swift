//
//  UserDetailsData.swift
//  CarGo
//
//  Created by Andrei Mirica on 09.02.2023.
//

import Foundation

struct UserDetailsData: Encodable, Decodable {
    var id: String?
    var name: String
    var about: String
    var country: String
    var city: String
    var job: String
    var profileImage: Data
    var spokenLanguages: [String]
}
