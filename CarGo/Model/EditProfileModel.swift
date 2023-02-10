//
//  EditProfileModel.swift
//  CarGo
//
//  Created by Andrei Mirica on 09.02.2023.
//

import Foundation

struct EditProfileModel {
    
    func editProfile(userDetails: UserDetailsData) async throws -> (UserDetailsData?, NetworkError?) {
        do {
            let(data, error) = await EditProfileService.editProfile(userDetails: userDetails)
            
            guard let data = data else {
                guard let error = error else {
                    return (nil, .unexpectedError)
                }
                
                return (nil, error)
            }
            
            do {
                let response = try JSONDecoder().decode(UserDetailsData.self, from: data)
                return (response, nil)
            } catch {
                do {
                    _ = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    return (nil, .invalidAccount)
                } catch {
                    return (nil, .jsonDecoder)
                }
            }
        }
    }
}
