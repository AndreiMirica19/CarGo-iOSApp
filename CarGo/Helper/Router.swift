//
//  Router.swift
//  CarGo
//
//  Created by Andrei Mirica on 10.02.2023.
//

import Foundation

final class Router<T: Hashable>: ObservableObject {
    @Published var paths: [T] = []
    
    func push(_ path: T) {
        paths.append(path)
    }
}

enum ProfilePaths {
    case profileView
    case profileDetails
    case editProfile
    case account
}

enum AddCarPaths {
    case addCarNumberPlate
    case addCarDetails
    case addCarDescription
    case addCarLocation
    case addCarPhotos
    case addCarPrice
}
