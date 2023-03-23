//
//  CarRepository.swift
//  CarGo
//
//  Created by Andrei Mirica on 01.03.2023.
//

import Foundation

struct CarRepository {
    static let shared = CarRepository()
    
    func fetchCars() async throws -> ([CarDto]?, NetworkError?) {
        do {
            let (data, error) = try await FetchCarsService.fetchCars()
            
            guard let data = data else {
                guard let error = error else {
                    return (nil, .unexpectedError)
                }
                
                return (nil, error)
            }
            
            do {
                let response = try JSONDecoder().decode([CarDto].self, from: data)
                return (response, nil)
            } catch {
                return (nil, .unexpectedError)
            }
        }
    }
    
    func addCar(carData: CarData) async throws -> (Response?, NetworkError?) {
        do {
            carData.ownerId = UserRepository.shared.userId
            let (data, error) = try await AddCarService.addCar(carData: carData)
            
            guard let data = data else {
                guard let error = error else {
                    return (nil, .unexpectedError)
                }
                
                return (nil, error)
            }
            
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                return (response, nil)
            } catch {
                return (nil, .unexpectedError)
            }
        }
    }
    
    func ownedCars() async throws -> ([CarInfoDTO]?, NetworkError?) {
        do {
            let (data, error) = try await OwnedCarsService.ownedCars(ownerId: UserRepository.shared.userId)
            
            guard let data = data else {
                guard let error = error else {
                    return (nil, .unexpectedError)
                }
                
                return (nil, error)
            }
            
            do {
                let response = try JSONDecoder().decode([CarInfoDTO].self, from: data)
                return (response, nil)
            } catch {
                return (nil, .unexpectedError)
            }
        }
    }
    
    func hostInfo(id: String) async throws -> (HostInfoDTO?, NetworkError?) {
        do {
            let (data, error) = try await HostInfoService.hostInfo(id: id)
            
            guard let data = data else {
                guard let error = error else {
                    return (nil, .unexpectedError)
                }
                
                return (nil, error)
            }
            
            do {
                let response = try JSONDecoder().decode(HostInfoDTO.self, from: data)
                return (response, nil)
            } catch {
                return (nil, .unexpectedError)
            }
        }
    }
    
    func allCars() async throws -> ([CarInfoDTO]?, NetworkError?) {
        do {
            let (data, error) = try await AllCarsService.allCars()
            
            guard let data = data else {
                guard let error = error else {
                    return (nil, .unexpectedError)
                }
                
                return (nil, error)
            }
            
            do {
                let response = try JSONDecoder().decode([CarInfoDTO].self, from: data)
                return (response, nil)
            } catch {
                return (nil, .unexpectedError)
            }
        }
    }
}
