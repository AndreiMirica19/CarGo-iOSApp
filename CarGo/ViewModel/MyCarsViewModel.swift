//
//  MyCarsViewModel.swift
//  CarGo
//
//  Created by Andrei Mirica on 07.03.2023.
//

import Foundation

class MyCarsViewModel: ObservableObject {
    @Published var ownedCarsResponse: ([CarInfoDTO]?, NetworkError?) = (nil, nil)
    
    func ownedCars() {
        Task {
            let response = try await CarRepository.shared.ownedCars()
            
            DispatchQueue.main.async {
                self.ownedCarsResponse = response
                
            }
        }
    }
}
