//
//  HostViewModel.swift
//  CarGo
//
//  Created by Andrei Mirica on 20.03.2023.
//

import Foundation

class HostViewModel: ObservableObject {
    @Published var hostInfoResponse: (HostInfoDTO?, NetworkError?) = (nil, nil)
    
    func hostInfo(id: String) {
        Task {
            let response = try await CarRepository.shared.hostInfo(id: id)
            
            DispatchQueue.main.async {
                self.hostInfoResponse = response
                
            }
        }
    }
}
