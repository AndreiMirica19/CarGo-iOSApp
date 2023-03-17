//
//  CarDetailsView.swift
//  CarGo
//
//  Created by Andrei Mirica on 08.03.2023.
//

import SwiftUI

struct CarDetailsView: View {
    var options = ["Car info", "Booking calendar", "Host"]
    var carData: CarInfoDTO
    @State var selectedOption = 0
    var body: some View {
        
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ScrollView {
                    TabView {
                        ForEach(carData.photos, id: \.self) { photoData in
                            
                            if let carImage = UIImage(data: photoData) {
                                Image(uiImage: carImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .edgesIgnoringSafeArea(.top)
                                }

                        }
                    }.tabViewStyle(.page)
                        .frame(height: geometry.size.height * 0.5)
                    
                }.scrollDisabled(true)
                
                Picker(selection: $selectedOption, label: Text("")) {
                    Text("Car Info").tag(0)
                    Text("Booking Calendar").tag(1)
                    Text("Host").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())

                

                
                switch selectedOption {
                case 0:
                    CarInfoView(carInfo: carData)
                    
                case 2:
                    CarHostView()
                    
                default:
                    EmptyView()
                }
            }
        }.edgesIgnoringSafeArea(.top)
    }
}

struct CarDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CarDetailsView(carData: CarInfoDTO(id: "", ownerId: "", numberPlate: "", manufacturer: "", model: "", carType: "", manufactureYear: "", transmission: "", color: "", fuel: "", numberSeats: "", description: "", street: "", city: "", country: "", photos: [], price: "", currency: "", discount: false))
    }
}
