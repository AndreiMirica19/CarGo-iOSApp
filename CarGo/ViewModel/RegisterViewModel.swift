//
//  RegisterViewModel.swift
//  CarGo
//
//  Created by Andrei Mirica on 15.01.2023.
//

import Foundation

class RegisterViewModel: ObservableObject, Equatable {
    let userRepository = UserRepository()
    
    @Published var response: (Response?, NetworkError?) = (nil, nil)

    static func == (lhs: RegisterViewModel, rhs: RegisterViewModel) -> Bool {
        return lhs.response == rhs.response
        }

    func register(registerData: RegisterData) {
        Task {
           let response = try await userRepository.register(registerData: registerData)

            DispatchQueue.main.async {
                self.response = response
            }
        }
    }
    
}
