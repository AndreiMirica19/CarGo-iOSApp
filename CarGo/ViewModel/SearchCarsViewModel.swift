//
//  SearchCarsViewModel.swift
//  CarGo
//
//  Created by Andrei Mirica on 20.03.2023.
//

import Foundation

class SearchCarsViewModel: ObservableObject {
    @Published var allCarsResponse: ([CarInfoDTO]?, NetworkError?) = (nil, nil)
    @Published var favoriteCarToggledResponse: ([CarInfoDTO]?, NetworkError?) = (nil, nil)
    @Published var favoriteCarsResponse: ([CarInfoDTO]?, NetworkError?) = (nil, nil)
    var locationManager = LocationManager()
    
    func getAllCars() {
        Task {
            let response = try await CarRepository.shared.allCars()
            
            DispatchQueue.main.async {
                self.allCarsResponse = response
            }
        }
    }
    
    func filterCars(filterData: FilterData) -> [CarInfoDTO] {
        guard var allCars = allCarsResponse.0 else {
            return []
        }
        
        if !filterData.carTypes.isEmpty {
           allCars = allCars.filter { filterData.carTypes.contains($0.carType) }
        }
        
        if !filterData.transmission.isEmpty {
           allCars = allCars.filter { filterData.transmission.contains($0.transmission) }
        }
        
        if filterData.fuel != "-" {
            allCars = allCars.filter { $0.fuel == filterData.fuel }
        }
        
        if filterData.color != "-" {
            allCars = allCars.filter { $0.color == filterData.color }
        }
        
        if filterData.carModel != "-" {
            allCars = allCars.filter { $0.model == filterData.carModel }
        }
        
        if filterData.manufacturer != "-" {
            allCars = allCars.filter { $0.manufacturer == filterData.manufacturer }
        }
        
        if filterData.endPrice < 200 {
            let priceRange = (Int(filterData.startPrice)...(Int(filterData.endPrice)))
            allCars = allCars.filter { priceRange.contains(Int($0.price) ?? 0) }
        } else {
            allCars = allCars.filter { (Int($0.price) ?? 0) > filterData.startPrice }
        }
        
        let yearRange = (Int(filterData.startYear)...(Int(filterData.endYear)))
        
        if filterData.radius > 0.0 {
            
        }
        
        return allCars.filter { yearRange.contains(Int($0.manufactureYear) ?? 0) }
    }
    
    func filterByAddress(address: String) -> [CarInfoDTO] {
        guard let allCars = allCarsResponse.0 else {
            return []
        }
        
         return allCars.filter {
             "\($0.city), \($0.country)" == address.folding(options: .diacriticInsensitive, locale: .current)
             
         }
    }
    
    func dateRangeToString(fromDate: Date?, toDate: Date?) -> String {
        
        guard let fromDate = fromDate, let toDate = toDate else {
            return ""
        }
        
        return "\(fromDate.formatted(date: .abbreviated, time: .omitted)) - \(toDate.formatted(date: .abbreviated, time: .omitted))"
        
    }
    
    func resetFilters() -> [CarInfoDTO] {
        guard let allCars = allCarsResponse.0 else {
            return []
        }
        
        return allCars
    }
    
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
