//
//  ProfileViewModel.swift
//  CarGo
//
//  Created by Andrei Mirica on 09.02.2023.
//

import Foundation

class ProfileViewModel: ObservableObject {

    @Published var response: (UserDetailsData?, NetworkError?) = (nil, nil)
    let userRepository = UserRepository()
    
    func userInfo() {
        Task {
            let response = try await userRepository.userInfo()
            
            DispatchQueue.main.async {
                self.response = response
                
            }
        }
    }
}
