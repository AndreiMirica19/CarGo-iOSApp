//
//  CarDetailsView.swift
//  CarGo
//
//  Created by Andrei Mirica on 08.03.2023.
//

import SwiftUI

struct CarDetailsView: View {
    @State var selectedOption = 0
    @StateObject var carDetailsViewModel = CarDetailsViewModel()
    @State var bookingSuccessful = false
    @State var errorAlertisShown = false
    @State var errorMessage = ""
    var options = ["Car info", "Booking calendar", "Host"]
    var carData: CarInfoDTO
    var fromDate: Date?
    var toDate: Date?
    
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
                    CarHostView(ownerId: carData.ownerId)
                    
                default:
                    EmptyView()
                }
                
                if !UserRepository.shared.isRenterViewActive {
                    BookingBanner(fromDate: fromDate, toDate: toDate, price: carData.price) { fromDate, toDate in
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        let fromDateString = dateFormatter.string(from: fromDate)
                        let toDateString = dateFormatter.string(from: toDate)
                        
                        carDetailsViewModel.bookCar(bookCarData: BookCarData(ownerId: carData.ownerId, renterId: UserRepository.shared.userId, carId: carData.id, fromDate: fromDateString, toDate: toDateString, status: "Pending"))
                        
                    }
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.gray, lineWidth: 1)
                        )
                        .padding()
                }
            }.onReceive(carDetailsViewModel.$bookCarResponse) { response in
                guard let successfulResponse = response.0 else {
                    guard let errorResponse = response.1 else {
                        return
                    }
                    
                    errorAlertisShown = true
                    errorMessage = errorResponse.getErrorMessage()
                    return
                }
                
                if successfulResponse.statusCode == 201 {
                    bookingSuccessful = true
                } else {
                    errorMessage = successfulResponse.message
                    errorAlertisShown = true
                }
            }
            .alert(errorMessage, isPresented: $errorAlertisShown) {
                Button("OK", role: .cancel) {}
            }
            .alert("Booking successful", isPresented: $bookingSuccessful) {
                Button("OK", role: .cancel) {}
            }
        }.edgesIgnoringSafeArea(.top)
    }
}

struct CarDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CarDetailsView(carData: CarInfoDTO(id: "", ownerId: "", numberPlate: "", manufacturer: "", model: "", carType: "", manufactureYear: "", transmission: "", color: "", fuel: "", numberSeats: "", description: "", street: "", city: "", country: "", photos: [], price: "", currency: "", discount: false))
    }
}
