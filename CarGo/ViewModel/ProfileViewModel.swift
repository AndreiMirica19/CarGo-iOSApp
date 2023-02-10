//
//  ProfileViewModel.swift
//  CarGo
//
//  Created by Andrei Mirica on 09.02.2023.
//

import Foundation

class ProfileViewModel: ObservableObject {

    @Published var response: (UserDetailsData?, NetworkError?) = (nil, nil)
    let userInfoModel = UserInfoModel()
    
    func userInfo() {
        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
            return
        }
        Task {
            let response = try await userInfoModel.userInfo(userId: userId)
            
            DispatchQueue.main.async {
                self.response = response
                
            }
        }
    }
}
