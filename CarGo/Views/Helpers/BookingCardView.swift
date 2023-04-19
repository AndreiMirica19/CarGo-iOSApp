//
//  BookingCardView.swift
//  CarGo
//
//  Created by Andrei Mirica on 12.04.2023.
//

import SwiftUI

struct BookingCardView: View {
    var bookingInfo: BookingInfo
    
    var body: some View {
        HStack {
            if let carPhotoData = bookingInfo.carInfo.photos.first {
                if let carPhotoImage = UIImage(data: carPhotoData) {
                    Image(uiImage: carPhotoImage)
                        .resizable()
                        .cornerRadius(8)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80)
                        .padding(.trailing, 16)
                        .scaledToFit()
                }
            }
            
            VStack(alignment: .leading) {
                Text("\(bookingInfo.carInfo.manufacturer), \(bookingInfo.carInfo.model)")
                    .foregroundColor(.black)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text("\(bookingInfo.fromDate.localTimezoneDateString())")
                    .foregroundColor(.gray)
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("\(bookingInfo.toDate.localTimezoneDateString())")
                    .foregroundColor(.gray)
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text(bookingInfo.getStatus())
                    .foregroundColor(bookingStatusColor())
                    .fontWeight(.semibold)
            }
        }.padding()
    }
    
    func bookingStatusColor() -> Color {
        let status = BookingStatus(rawValue: bookingInfo.getStatus())
        
        switch status {
            
        case .cancelled, .hostCancelled:
            return .red
            
        case .pending:
            return Color("pendingYellow")
            
        case .accepted:
            return .green
            
        case .completed:
            return Color("darkBlue")
            
        case .inProgress:
            return Color("lightBlue")
            
        case .none:
            return .black
        }
    }
}

struct BookingCardView_Previews: PreviewProvider {
    static var previews: some View {
        BookingCardView(bookingInfo: BookingInfo(toDate: "", status: "", renterDetails: UserDetailsData(name: "", about: "", country: "", city: "", job: "", profileImage: Data(), spokenLanguages: [], favoriteCars: []), id: "", carInfo: CarInfoDTO(id: "", ownerId: "", numberPlate: "", manufacturer: "", model: "", carType: "", manufactureYear: "", transmission: "", color: "", fuel: "", numberSeats: "", description: "", street: "", city: "", country: "", photos: [], price: "", currency: "", discount: true), fromDate: "", hostInfo: HostInfoDTO(hostDetails: UserDetailsData(name: "", about: "", country: "", city: "", job: "", profileImage: Data(), spokenLanguages: [], favoriteCars: []), ownedCars: [], reviews: [])))
            .frame(height: 128)
    }
}
