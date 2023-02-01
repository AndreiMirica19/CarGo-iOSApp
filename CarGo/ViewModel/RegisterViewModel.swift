//
//  RegisterViewModel.swift
//  CarGo
//
//  Created by Andrei Mirica on 15.01.2023.
//

import Foundation

class RegisterViewModel: ObservableObject, Equatable {
    let registerModel = RegisterModel()
    
    @Published var response: (Response?, NetworkError?) = (nil, nil)

    static func == (lhs: RegisterViewModel, rhs: RegisterViewModel) -> Bool {
        return lhs.response == rhs.response
        }

    func register(registerData: RegisterData) {
        Task {
           let response = try await registerModel.register(registerData: registerData)

            DispatchQueue.main.async {
                self.response = response
            }
        }
    }
    
}
