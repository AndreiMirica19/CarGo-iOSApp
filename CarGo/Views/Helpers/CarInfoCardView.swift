//
//  CarInfoCardView.swift
//  CarGo
//
//  Created by Andrei Mirica on 20.03.2023.
//

import SwiftUI

struct CarInfoCardView: View {
    var carInfo: CarInfoDTO
    var hostViewModel = HostViewModel()
    @State var profileImageData = Data()
    @State var errorMessage = ""
    var addedToFavorite: Bool
    @State var isErrorDisplayed = false
    @State var locationManager = LocationManager()
    @State var distance = "0.0"
    var fromDate: Date?
    var toDate: Date?
    var toggleFavorite: (() -> Void)

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack(alignment: .topTrailing) {
                
                if let imageData = carInfo.photos.first {
                    if let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
                
                if !UserRepository.shared.isRenterViewActive {
                    VStack {
                        
                        ZStack {
                            Circle()
                                .fill(Color.gray.opacity(0.1))
                            
                            Image(systemName: addedToFavorite ? "heart.fill" : "heart")
                                .resizable()
                                .padding(8)
                                .foregroundColor(.white)
                                .scaleEffect(addedToFavorite ? 1.2 : 1)
                                .onTapGesture {
                                    withAnimation {
                                        toggleFavorite()
                                    }
                                }
                        }
                        .frame(width: 42, height: 42)
                        .padding(.top)
                        .padding(.trailing)
                        
                        Spacer()
                        
                        Image(uiImage: UIImage(data: profileImageData) ?? UIImage())
                            .resizable()
                            .frame(width: 48, height: 48)
                            .clipShape(Circle())
                            .padding(.bottom)
                            .padding(.trailing)
                    }
                }
            }
            
            HStack {
                Text("\(carInfo.manufacturer) \(carInfo.model)")
                
                Spacer()
                
                ForEach(0...5, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 16, height: 16)
                }
                
                Text("(100)")
                    .padding(.trailing, 4)
            }
            
            HStack {
                Text(carInfo.manufactureYear)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("\(distance) km away")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.trailing, 4)
            }
            
            if let fromDate = fromDate, let toDate = toDate {
                let numberOfDaysComponent = Calendar.current.dateComponents([.day], from: fromDate, to: toDate)
                if let numberOfDays = numberOfDaysComponent.day, let price = Int(carInfo.price) {
                    Text("$\(price * numberOfDays) per \(numberOfDays) days")
                        .font(.headline)
                }
            } else {
                Text("$\(carInfo.price) per day")
                    .font(.headline)
            }
            
        }.frame(maxWidth: .infinity, alignment: .leading)
            .onAppear {
                hostViewModel.hostInfo(id: carInfo.ownerId)
            }
            .onReceive(hostViewModel.$hostInfoResponse) { response in
                guard let hostInfo = response.0 else {
                    guard let error = response.1 else {
                        return
                    }
                    
                    self.errorMessage = error.getErrorMessage()
                    self.isErrorDisplayed = true
                    return
                }
                profileImageData = hostInfo.hostDetails.profileImage
            }
            .onReceive(locationManager.$region, perform: { _ in
                locationManager.distanceFromAddress(address: "\(carInfo.street), \(carInfo.city), \(carInfo.country)")
            })
            .onReceive(locationManager.$distance, perform: { distance in
                self.distance = distance
            })
            .alert(errorMessage, isPresented: $isErrorDisplayed) {
                Button("Ok", role: .cancel) {
                    
                }
            }
    }
}

struct CarInfoCardView_Previews: PreviewProvider {
    static var previews: some View {
        CarInfoCardView(carInfo: CarInfoDTO(id: "", ownerId: "", numberPlate: "", manufacturer: "", model: "", carType: "", manufactureYear: "", transmission: "", color: "", fuel: "", numberSeats: "", description: "", street: "", city: "", country: "", photos: [], price: "", currency: "", discount: false), addedToFavorite: (true)) {
            
        }
        .frame(height: 360)
    }
}
