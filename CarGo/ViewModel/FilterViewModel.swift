//
//  FilterViewModel.swift
//  CarGo
//
//  Created by Andrei Mirica on 28.03.2023.
//

import Foundation

class FilterViewMode: ObservableObject {
    @Published var carListResponse: ([CarDto]?, NetworkError?) = (nil, nil)
    @Published var selectedCarTypes: [String] = []
    
    func fetchCars() {
        Task {
            let response = try await CarRepository.shared.fetchCars()
            
            DispatchQueue.main.async {
                self.carListResponse = response
                
            }
        }
    }
    
    func getCarManufacturers() -> [String] {
        
        guard let carList = carListResponse.0 else {
            return ["-"]
        }
        
        var manufacturers = Array(Set(carList.map { $0.manufacturer }))
        manufacturers.append("-")
        return manufacturers.sorted()
    }
    
    func getCarModels(carManufacturer: String) -> [String] {
        
        guard let carList = carListResponse.0 else {
            return ["-"]
        }
        
        let cars = carList.filter({ car in
            return car.manufacturer == carManufacturer
        })
        
        var models = Array(Set(cars.map { $0.model }))
        models.append("-")
        
        return models.sorted()
    }
}
