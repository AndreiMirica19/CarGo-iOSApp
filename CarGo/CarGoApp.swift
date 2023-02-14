//
//  CarGoApp.swift
//  CarGo
//
//  Created by Andrei Mirica on 18.12.2022.
//

import SwiftUI

@main
struct CarGoApp: App {
    
    @StateObject var userRepository = UserRepository.shared
    @State var loginSuccessful = false
    
    var body: some Scene {
            WindowGroup {
                VStack {
                    if userRepository.isLoggedIn {
                        RentingContentView()
                    } else {
                        if loginSuccessful {
                            RentingContentView()
                        } else {
                            LoginView()
                        }
                    }
                }.onReceive(userRepository.$isLoggedIn) { isLoggedIn in
                    if !isLoggedIn {
                        loginSuccessful = false
                    }
                }
            }
        }
    }
