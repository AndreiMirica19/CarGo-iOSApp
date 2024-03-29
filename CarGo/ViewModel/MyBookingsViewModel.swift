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
    
    func ownerBookings() {
        Task {
            let response = try await BookingRepository.shared.ownerBookings()
            
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
            return booking.toDate.toDate()?.compare(Date.now) == .orderedDescending && booking.status != BookingStatus.cancelled.rawValue && booking.status != BookingStatus.hostCancelled.rawValue && booking.status != BookingStatus.completed.rawValue
        }
    }
    
    func getCompletedBookings() -> [BookingInfo] {
        guard let bookings = myBookingsResponse.0 else {
            return []
        }
        
        return bookings.filter { $0.toDate.toDate()?.compare(Date.now) == .orderedAscending || $0.status == BookingStatus.cancelled.rawValue || $0.status == BookingStatus.hostCancelled.rawValue || $0.status == BookingStatus.completed.rawValue }
    }
}
