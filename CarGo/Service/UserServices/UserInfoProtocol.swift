//
//  UserInfoProtocol.swift
//  CarGo
//
//  Created by Andrei Mirica on 09.02.2023.
//

import Foundation

protocol UserInfoProtocol {
    static func userInfo(userId: String) async -> (Data?, NetworkError?)
}
