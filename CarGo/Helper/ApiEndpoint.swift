//
//  ApiEndpoint.swift
//  CarGo
//
//  Created by Andrei Mirica on 09.02.2023.
//

import Foundation

enum ApiEndpoint: String {
    static let url = "http://localhost:8080"
    
    case register = "/register"
    case login = "/login"
    case editProfile = "/editUserDetails"
    case userDetails = "/userDetails"
    case accountInfo = "/accountInfo"
    case changeEmail = "/changeEmail"
    case changePhoneNumber = "/changePhoneNumber"
    case changePassword = "/changePassword"
    case deleteAccount = "/deleteAccount"
    case toggleFavoriteCar = "/toggleFavoriteCar"
    case favoriteCars = "/favoriteCars"
    
    case carList = "/cars"
    case addCar = "/addCar"
    case ownedCars = "/ownedCars"
    case allCars = "/allCars"
    
    case hostInfo = "/hostInfo"
}
