//
//  CarGoApp.swift
//  CarGo
//
//  Created by Andrei Mirica on 18.12.2022.
//

import SwiftUI

@main
struct CarGoApp: App {
    let userId = UserDefaults.standard.string(forKey: "userId")
    var body: some Scene {
 
        return WindowGroup {
            VStack {
                if userId != nil {
                    RentingContentView()
                } else {
                    LoginView()
                }
            }
        }
    }
    
    init() {
        if let userId = userId {
            UserRepository.userId = userId
        }
    }
}
