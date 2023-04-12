//
//  CarDetailsViewModel.swift
//  CarGo
//
//  Created by Andrei Mirica on 11.04.2023.
//

import Foundation

class CarDetailsViewModel: ObservableObject {
    @Published var bookCarResponse: (Response?, NetworkError?) = (nil, nil)
    
    func bookCar(bookCarData: BookCarData) {
        Task {
            let response = try await BookingRepository.shared.bookCar(bookCarData: bookCarData)
            
            DispatchQueue.main.async {
                self.bookCarResponse = response
            }
        }
    }
}
