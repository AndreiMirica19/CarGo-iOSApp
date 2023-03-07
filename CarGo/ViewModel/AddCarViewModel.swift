//
//  AddCarViewModel.swift
//  CarGo
//
//  Created by Andrei Mirica on 01.03.2023.
//

import Foundation
import CoreLocation
import MapKit

struct IdentifiablePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    
    init(id: UUID = UUID(), lat: Double, long: Double) {
        self.id = id
        self.location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long
        )
    }
}

class AddCarViewModel: ObservableObject {
    
    @Published var carListResponse: ([CarDto]?, NetworkError?) = (nil, nil)
    @Published var region: (region: MKCoordinateRegion?, Error?)
    @Published var addCarResponse: (Response?, NetworkError?) = (nil, nil)
    var places: [IdentifiablePlace] = []
    
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
    
    func addCar(carData: CarData) {
        Task {
            let response = try await CarRepository.shared.addCar(carData: carData)
            
            DispatchQueue.main.async {
                self.addCarResponse = response
            }
        }
    }
}
