//
//  ProfileViewModel.swift
//  CarGo
//
//  Created by Andrei Mirica on 09.02.2023.
//

import Foundation

class ProfileViewModel: ObservableObject {

    @Published var response: (UserDetailsData?, NetworkError?) = (nil, nil)
    @Published var accountResponse: (UserDTO?, NetworkError?) = (nil, nil)
    @Published var changeEmailResponse: (Response?, NetworkError?) = (nil, nil)
    @Published var changePhoneNumberResponse: (Response?, NetworkError?) = (nil, nil)
    
    let userRepository = UserRepository()
    
    func userInfo() {
        Task {
            let response = try await userRepository.userInfo()
            
            DispatchQueue.main.async {
                self.response = response
                
            }
        }
    }
    
    func accountInfo() {
        Task {
            let response = try await userRepository.accountInfo()
            
            DispatchQueue.main.async {
                self.accountResponse = response
                
            }
        }
    }
    
    func changeEmail(email: String) {
        Task {
            let response = try await userRepository.changeEmail(email: email)
            
            DispatchQueue.main.async {
                self.changeEmailResponse = response
                
            }
        }
    }
    
    func changePhoneNumber(phoneNumber: String) {
        Task {
            let response = try await userRepository.changePhoneNumber(phoneNumber: phoneNumber)
            
            DispatchQueue.main.async {
                self.changePhoneNumberResponse = response
                
            }
        }
    }
}
