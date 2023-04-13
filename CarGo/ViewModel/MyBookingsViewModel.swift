//
//  MyBookingsViewModel.swift
//  CarGo
//
//  Created by Andrei Mirica on 12.04.2023.
//

import Foundation

class MyBookingsViewModel: ObservableObject {
    @Published var myBookingsResponse: ([BookingInfo]?, NetworkError?)
    
    func userBookings() {
        Task {
            let response = try await BookingRepository.shared.userBookings()
            
            DispatchQueue.main.async {
                self.myBookingsResponse = response
            }
        }
    }
    
    func getUpcomingBookings() -> [BookingInfo] {
        guard let bookings = myBookingsResponse.0 else {
            return []
        }
        
        return bookings.filter { booking in
            return booking.toDate.toDate()?.compare(Date.now) == .orderedAscending
        }
    }
    
    func getCompletedBookings() -> [BookingInfo] {
        guard let bookings = myBookingsResponse.0 else {
            return []
        }

        return bookings.filter { $0.toDate.toDate()?.compare(Date.now) == .orderedAscending }
    }
}
