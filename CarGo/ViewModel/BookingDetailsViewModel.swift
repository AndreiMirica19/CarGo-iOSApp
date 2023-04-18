//
//  BookingDetailsViewModel.swift
//  CarGo
//
//  Created by Andrei Mirica on 18.04.2023.
//

import Foundation

class BookingDetailsViewModel: ObservableObject {
    @Published var bookingStatusResponse: (Response?, NetworkError?)
    
    func changeBookingStatus(bookingId: String, status: String) {
        Task {
            let response = try await BookingRepository.shared.updateStatus(bookingId: bookingId, status: status)
            
            DispatchQueue.main.async {
                self.bookingStatusResponse = response
            }
        }
    }
}
