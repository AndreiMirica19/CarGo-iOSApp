//
//  EditProfileProtocol.swift
//  CarGo
//
//  Created by Andrei Mirica on 09.02.2023.
//

import Foundation

protocol EditProfileProtocol {
    static func editProfile(userDetails: UserDetailsData) async -> (Data?, NetworkError?)
}
