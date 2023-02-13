//
//  EditProfileViewModel.swift
//  CarGo
//
//  Created by Andrei Mirica on 09.02.2023.
//

import Foundation

class EditProfileViewModel {
    
    @Published var response: (UserDetailsData?, NetworkError?) = (nil, nil)
    let userRepository = UserRepository()
    
    func editProfile(userDetails: UserDetailsData) {
        Task {
 
            var userDet = userDetails
            userDet.id = UserDefaults.standard.string(forKey: "userId")
            
            let response = try await userRepository.editProfile(userDetails: userDet)
            
            DispatchQueue.main.async {
                self.response = response
                
            }
        }
    }
    
}
