//
//  LoginViewModel.swift
//  CarGo
//
//  Created by Andrei Mirica on 17.01.2023.
//

import Foundation

class LoginViewModel: ObservableObject {
    let userRepository = UserRepository()
    
    @Published var response: (LoginDTO?, NetworkError?) = (nil, nil)
    
    func login(loginData: LoginData, keepLogedIn: Bool) {
        Task {
            let response = try await userRepository.login(loginData: loginData)
            
            DispatchQueue.main.async {
                self.response = response
                
                if keepLogedIn {
                    guard let userData = response.0 else {
                        return
                    }
                    
                    UserDefaults.standard.set(userData.id, forKey: "userId")
                }
            }
        }
    }
}
