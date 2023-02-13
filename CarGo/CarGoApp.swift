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
    @State var loginSuccessful = false
    var body: some Scene {
 
        return WindowGroup {
            VStack {
                if userId != nil {
                    RentingContentView(loginSuccessful: $loginSuccessful)
                } else {
                    if loginSuccessful {
                        RentingContentView(loginSuccessful: $loginSuccessful)
                    } else {
                        LoginView(loginSuccessful: $loginSuccessful)
                    }
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
