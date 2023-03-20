//
//  CarCardView.swift
//  CarGo
//
//  Created by Andrei Mirica on 17.03.2023.
//

import SwiftUI

struct CarCardView: View {
    
    var carInfo: CarInfoDTO
    var body: some View {
        VStack(alignment: .leading) {
            if let carPhotoData = carInfo.photos.first {
                if let carPhotoImage = UIImage(data: carPhotoData) {
                    Image(uiImage: carPhotoImage)
                        .resizable()
                        .cornerRadius(24.0)
                        .scaledToFill()
                        .frame(width: .infinity)
                }
            }

            Text("\(carInfo.model), \(carInfo.manufacturer)")
                .foregroundColor(.black)
                .font(.headline)
                .fontWeight(.bold)
                .frame(width: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Text(carInfo.manufactureYear)
                .foregroundColor(.gray)
                .font(.headline)
                .fontWeight(.bold)
                .frame(width: .infinity, alignment: .leading)
                .padding(.horizontal)
        }.padding()
    }
}

struct CarCardView_Previews: PreviewProvider {
    static var previews: some View {
        CarCardView(carInfo: CarInfoDTO(id: "", ownerId: "", numberPlate: "", manufacturer: "", model: "", carType: "", manufactureYear: "", transmission: "", color: "", fuel: "", numberSeats: "", description: "", street: "", city: "", country: "", photos: [], price: "", currency: "", discount: false))
            .frame(width: 248, height: 224)
    }
}
