//
//  EditProfileService.swift
//  CarGo
//
//  Created by Andrei Mirica on 09.02.2023.
//

import Foundation

struct EditProfileService: EditProfileProtocol {
    static func editProfile(userDetails: UserDetailsData) async -> (Data?, NetworkError?) {
        
        guard let url = URL(string: ApiEndpoint.url + ApiEndpoint.editProfile.rawValue) else {
            return (nil, .invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let jsonData = try JSONEncoder().encode(userDetails)
            request.httpBody = jsonData
            let (data, _) = try await URLSession.shared.data(for: request)

            return (data, nil)
        } catch {
            return (nil, .invalidBody)
        }
    }
}
