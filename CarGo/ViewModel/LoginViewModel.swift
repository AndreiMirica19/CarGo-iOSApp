//
//  LoginViewModel.swift
//  CarGo
//
//  Created by Andrei Mirica on 17.01.2023.
//

import Foundation

class LoginViewModel: ObservableObject {

    @Published var response: (UserDTO?, NetworkError?) = (nil, nil)
    
    func login(loginData: LoginData, keepLogedIn: Bool) {
        Task {
            let response = try await UserRepository.shared.login(loginData: loginData)
            
            DispatchQueue.main.async {
                self.response = response
                
                guard let userData = response.0 else {
                    return
                }
                
                if keepLogedIn {
                    UserDefaults.standard.set(userData.id, forKey: "userId")
                }
                
                UserRepository.shared.userId = userData.id
            }
        }
    }
}
