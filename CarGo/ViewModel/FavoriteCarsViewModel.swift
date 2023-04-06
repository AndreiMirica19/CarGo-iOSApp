//
//  FavoriteCarsViewModel.swift
//  CarGo
//
//  Created by Andrei Mirica on 06.04.2023.
//

import Foundation

class FavoriteCarsViewModel: ObservableObject {
    
    @Published var favoriteCarToggledResponse: ([CarInfoDTO]?, NetworkError?) = (nil, nil)
    @Published var favoriteCarsResponse: ([CarInfoDTO]?, NetworkError?) = (nil, nil)
    
    func toggleFavoriteCar(carId: String) {
        Task {
            let response = try await UserRepository.shared.toggleFavoriteCar(carId: carId)
            
            DispatchQueue.main.async {
                self.favoriteCarToggledResponse = response
            }
        }
    }
    
    func favoriteCars() {
        Task {
            let response = try await UserRepository.shared.favoriteCar()
            
            DispatchQueue.main.async {
                self.favoriteCarsResponse = response
            }
        }
    }

}
