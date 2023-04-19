//
//  BookedCarDTO.swift
//  CarGo
//
//  Created by Andrei Mirica on 12.04.2023.
//

import Foundation

struct BookingInfo: Decodable {
    let toDate: String
    let status: String
    let renterDetails: UserDetailsData
    let id: String
    let carInfo: CarInfoDTO
    let fromDate: String
    let hostInfo: HostInfoDTO

    func totalPrice() -> String {
        guard let fromDate = fromDate.toDate(), let toDate = toDate.toDate() else {
            return ""
        }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: fromDate, to: toDate)

        let numberOfDays = components.day
        
        guard let numberOfDays = numberOfDays else {
            return ""
        }
        
        return ("\(numberOfDays * (Int(carInfo.price) ?? 0))")
    }
    
    func getStatus() -> String {
        let status = BookingStatus(rawValue: status)
        
        switch status {
        case .accepted:
            if let startDate = fromDate.toDate(), let endDate = toDate.toDate() {
                if Date.now.isBetween(startDate, and: endDate) {
                    return BookingStatus.inProgress.rawValue
                }
            }
            
        case .pending:
            if let startDate = fromDate.toDate() {
                if Date.now.isAfter(startDate) {
                    return BookingStatus.hostCancelled.rawValue
                }
            }
            
        default:
            break
        }
        return self.status
    }
}
