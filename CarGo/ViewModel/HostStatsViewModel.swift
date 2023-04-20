//
//  HostStatsViewModel.swift
//  CarGo
//
//  Created by Andrei Mirica on 20.04.2023.
//

import Foundation

class HostStatsViewModel: ObservableObject {
    @Published var hostStatsResponse: (HostStatsDTO?, NetworkError?) = (nil, nil)
    
    func hostStats() {
        Task {
            let response = try await BookingRepository.shared.hostStats()
            
            DispatchQueue.main.async {
                self.hostStatsResponse = response
            }
        }
    }
}
