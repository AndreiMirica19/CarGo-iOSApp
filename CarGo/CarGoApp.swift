//
//  CarGoApp.swift
//  CarGo
//
//  Created by Andrei Mirica on 18.12.2022.
//

import SwiftUI

@main
struct CarGoApp: App {
    
    var body: some Scene {
        let userId = UserDefaults.standard.string(forKey: "userId")
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
}
